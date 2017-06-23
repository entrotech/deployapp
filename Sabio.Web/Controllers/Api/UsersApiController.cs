﻿using Microsoft.AspNet.Identity.EntityFramework;
using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;
using Sabio.Web.Models.Responses;
using Sabio.Web.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using HtmlAgilityPack;
using Sabio.Web.Models;

namespace Sabio.Web.Controllers.Api
{
    [RoutePrefix("api/users")]
    public class UsersApiController : ApiController

    {
        private IEmailService _emailService = null;
        private IPersonService _personService = null;
        private IAspNetUserRoleService _aspNetUserRoleService = null;

        public UsersApiController(IEmailService emailService, IPersonService personService, IAspNetUserRoleService aspNetUserRoleService)
        {
            _emailService = emailService;
            _personService = personService;
            _aspNetUserRoleService = aspNetUserRoleService;
        }

        [Route, HttpPost]
        public async Task<HttpResponseMessage> Add(UserAddRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }
            IdentityUser entityUser = UserService.CreateUser(model.Email, model.Password);

            //Adds Newly created User to AspNetUserRoles table with the default role of 'user'
            AspNetUserRoleAddRequest role = new AspNetUserRoleAddRequest();
            role.UserId = entityUser.Id;
            role.Role = "user";
            _aspNetUserRoleService.Post(role);
            
            ItemResponse<Guid> response = await SendNewConfirmationEmail(model.FirstName, model.LastName, model.Email, entityUser.Id);

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
        [Route("{guid:Guid}"), HttpPut]
        public async Task<HttpResponseMessage> ResendConfirmationEmail(Guid guid)
        {
            SecurityToken securityToken = SecurityTokenService.SelectByGuid(guid);

            ItemResponse<Guid> response = await SendNewConfirmationEmail(securityToken.FirstName, securityToken.LastName, securityToken.Email, securityToken.AspNetUserId);

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        private async Task<ItemResponse<Guid>> SendNewConfirmationEmail(string firstName, string lastName, string email, string id)
        {
            SecurityTokenAddRequest securityToken = new SecurityTokenAddRequest();
            securityToken.FirstName = firstName;
            securityToken.LastName = lastName;
            securityToken.Email = email;
            securityToken.TokenTypeId = 1;
            securityToken.AspNetUserId = id;

            Guid emailSecurityToken = SecurityTokenService.Insert(securityToken);

            ConfirmationEmailRequest emailRequest = new ConfirmationEmailRequest();
            emailRequest.FirstName = firstName;
            emailRequest.LastName = lastName;
            emailRequest.Email = email;
            emailRequest.SecurityToken = emailSecurityToken;
            //Removed static to enable DI
            await _emailService.ConfirmRegistration(emailRequest);
            ItemResponse<Guid> response = new ItemResponse<Guid>();
            response.Item = emailSecurityToken;
            return response;
        }

        [Route("{guid:Guid}"), HttpGet]
        public HttpResponseMessage ConfirmToken(Guid guid)
        {
            SecurityToken securityToken = SecurityTokenService.SelectByGuid(guid);

            if (securityToken.AspNetUserId != null)
            {
                DateTime now = DateTime.UtcNow;
                TimeSpan daysElapsed = (now - securityToken.DateCreated);
                if (daysElapsed.TotalDays > 1)
                {
                    String errorMessage = "1|Not activated in 24 hours";
                    ErrorResponse response = new ErrorResponse(errorMessage);
                    return Request.CreateResponse(HttpStatusCode.NotAcceptable, response);
                }
                else
                {
                    UserService.ConfirmEmail(securityToken.AspNetUserId);
                    if (!_personService.CheckIfPerson(securityToken.AspNetUserId))
                    {
                        PersonAddRequest person = new PersonAddRequest();
                        person.FirstName = securityToken.FirstName;
                        person.LastName = securityToken.LastName;
                        person.Email = securityToken.Email;
                        person.AspNetUserId = securityToken.AspNetUserId;
                        int id = _personService.InsertFromRegister(person);
                    }
                    SuccessResponse response = new SuccessResponse();
                    return Request.CreateResponse(HttpStatusCode.OK, response);
                }
            }
            else
            {
                String errorMessage = "2|Confirm failed";
                ErrorResponse response = new ErrorResponse(errorMessage);
                return Request.CreateResponse(HttpStatusCode.BadRequest, response);
            }           
        }

        [AllowAnonymous]
        [Route("login"), HttpPost]
        public HttpResponseMessage Login(LoginAddRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }
          
          
            UserService service = new UserService();
            //LoginResponse lR = new LoginResponse();
            LoginResponse lR = service.Signin(model.Email, model.Password);
                if (lR.HasError)
            {
               
                return Request.CreateResponse(HttpStatusCode.Unauthorized, lR.Message);
            }
       
            else
            {
                SuccessResponse response = new SuccessResponse();
                return Request.CreateResponse(HttpStatusCode.OK, response);
            }
        }

        [Route("forgotpassword"), HttpPost]
        public async Task<HttpResponseMessage> VerifyUser(ConfirmationEmailRequest model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ModelState);
            }
            PersonBase pb = UserService.SelectByEmail(model.Email);
            if (pb == null)
            {
                ErrorResponse er = new ErrorResponse("This email is not associated with an account.");
                return Request.CreateResponse(HttpStatusCode.BadRequest, er);
            }
            ItemResponse<Guid> response = await SendResetPasswordEmail(pb, model);

            return Request.CreateResponse(HttpStatusCode.OK, response);

        }

        private async Task<ItemResponse<Guid>> SendResetPasswordEmail(PersonBase pb, ConfirmationEmailRequest model)
        {
            SecurityTokenAddRequest securityToken = new SecurityTokenAddRequest();
            securityToken.FirstName = pb.FirstName;
            securityToken.LastName = pb.LastName;
            securityToken.Email = model.Email;
            securityToken.TokenTypeId = 2;
            securityToken.AspNetUserId = "";

            Guid emailSecurityToken = SecurityTokenService.Insert(securityToken);

            ConfirmationEmailRequest emailRequest = new ConfirmationEmailRequest();
            emailRequest.FirstName = pb.FirstName;
            emailRequest.LastName = pb.LastName;
            emailRequest.Email = model.Email;
            emailRequest.SecurityToken = emailSecurityToken;

            await _emailService.ForgotPassword(emailRequest);

            ItemResponse<Guid> response = new ItemResponse<Guid>();
            response.Item = emailSecurityToken;
            return response;
        }
        [Route("resend/{guid:Guid}"), HttpPut]
        public async Task<HttpResponseMessage> ResendResetPasswordEmail(Guid guid)
        {
            SecurityToken securityToken = SecurityTokenService.SelectByGuid(guid);

            PersonBase pb = new PersonBase();
            pb.FirstName = securityToken.FirstName;
            pb.LastName = securityToken.LastName;
            pb.Email = securityToken.Email;

            ConfirmationEmailRequest r = new ConfirmationEmailRequest();
            r.Email = securityToken.Email;

            ItemResponse<Guid> response = await SendResetPasswordEmail(pb, r);

            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("reset/{guid:Guid}"), HttpGet]
        public HttpResponseMessage ConfirmResetToken(Guid guid)
        {
            SecurityToken securityToken = SecurityTokenService.SelectByGuid(guid);

            if (securityToken.AspNetUserId != null)
            {
                DateTime now = DateTime.UtcNow;
                TimeSpan daysElapsed = (now - securityToken.DateCreated);
                if (daysElapsed.TotalDays > 1)
                {
                    String errorMessage = "1|Not activated in 24 hours";
                    ErrorResponse response = new ErrorResponse(errorMessage);
                    return Request.CreateResponse(HttpStatusCode.NotAcceptable, response);
                }
                else
                {
                    ItemResponse<SecurityToken> response = new ItemResponse<SecurityToken>();
                    response.Item = securityToken;
                    return Request.CreateResponse(HttpStatusCode.OK, response);
                }
            }
            else
            {
                String errorMessage = "2|Confirm failed";
                ErrorResponse response = new ErrorResponse(errorMessage);
                return Request.CreateResponse(HttpStatusCode.BadRequest, response);
            }

        }
        [Route("resetpassword/{guid:Guid}"), HttpPut]  
        public HttpResponseMessage ResetPassWord(Guid guid, UserUpdateRequest model)
        {
            SecurityToken securityToken = SecurityTokenService.SelectByGuid(guid);

            UserService.ChangePassWord(securityToken.AspNetUserId, model.Password);
            ItemsResponse<bool> response = new ItemsResponse<bool>();
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
        [Route("home")][HttpGet]
        public HttpResponseMessage LoadHome()
        {
            string aspNetUserId = UserService.GetCurrentUserId();

            PersonBase pb = _personService.GetByAspNetUserId(aspNetUserId);
            Person p = _personService.PublicSelect(pb.Id);

            ItemResponse<Person> response = new ItemResponse<Person>();
            response.Item = p;
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        [Route("logout"), HttpGet]
        public HttpResponseMessage LogOut()
        {
            UserService.Logout();
            SuccessResponse response = new SuccessResponse();
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
    }
}
