﻿using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Sabio.Web.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.Identity.Owin;
using Sabio.Web.Exceptions;
using Microsoft.Owin.Security;
using System.Security.Claims;
using System.Data.SqlClient;
using System.Data.Entity.Validation;
using System.Diagnostics;
using System.Data;
using Sabio.Data;
using Sabio.Web.Models.Responses;
using Sabio.Web.Domain;
using Sabio.Web.Services;

namespace Sabio.Web.Requests
{
    public class UserService : BaseService
    {

        private static ApplicationUserManager GetUserManager()
        {
            return HttpContext.Current.GetOwinContext().GetUserManager<ApplicationUserManager>();
        }

        public static IdentityUser CreateUser(string email, string password)
        {
            ApplicationUserManager userManager = GetUserManager();

            ApplicationUser newUser = new ApplicationUser { UserName = email, Email = email, LockoutEnabled = false };
            IdentityResult result = null;
            try
            {
                result = userManager.Create(newUser, password);

            }
            catch
            {
                throw;
            }

            if (result.Succeeded)
            {
                return newUser;
            }
            else
            {
                throw new IdentityResultException(result);
            }
        }

        public static bool IsUser(string emailaddress)
        {
            bool result = false;

            ApplicationUserManager userManager = GetUserManager();
            IAuthenticationManager authenticationManager = HttpContext.Current.GetOwinContext().Authentication;

            ApplicationUser user = userManager.FindByEmail(emailaddress);


            if (user != null)
            {

                result = true;

            }

            return result;
        }

        public static ApplicationUser GetUser(string emailaddress)
        {


            ApplicationUserManager userManager = GetUserManager();
            IAuthenticationManager authenticationManager = HttpContext.Current.GetOwinContext().Authentication;

            ApplicationUser user = userManager.FindByEmail(emailaddress);

            return user;
        }
        public static PersonBase SelectByEmail(string email)
        {
            PersonBase person = null;
            DataProvider.ExecuteCmd(GetConnection, "dbo.Person_SelectByAspNetUsersEmail",
               inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   paramCollection.AddWithValue("@email", email);

               }
               , map: delegate (IDataReader reader, short set)
               {
                   switch (set)
                   {
                       case 0:
                           person = new PersonBase();
                           int startingIndex = 0; //startingOrdinal
                           person.Id = reader.GetSafeInt32(startingIndex++);
                           person.FirstName = reader.GetSafeString(startingIndex++);
                           person.MiddleName = reader.GetSafeString(startingIndex++);
                           person.LastName = reader.GetSafeString(startingIndex++);
                           person.PhoneNumber = reader.GetSafeString(startingIndex++);
                           person.Email = reader.GetSafeString(startingIndex++);
                           person.JobTitle = reader.GetSafeString(startingIndex++);
                           break;
                   }
               }
               );
            return person;
        }

        public static ApplicationUser GetUserById(string userId)
        {

            ApplicationUserManager userManager = GetUserManager();
            IAuthenticationManager authenticationManager = HttpContext.Current.GetOwinContext().Authentication;

            ApplicationUser user = userManager.FindById(userId);

            return user;
        }

        public static bool ChangePassWord(string userId, string password)
        {
            bool result = false;

            if (string.IsNullOrEmpty(userId) || string.IsNullOrEmpty(password))
            {
                throw new System.Exception("You must provide a userId and a password");
            }

            ApplicationUser user = GetUserById(userId);

            if (user != null)
            {

                ApplicationUserManager userManager = GetUserManager();

                userManager.RemovePassword(userId);
                IdentityResult res = userManager.AddPassword(userId, password);

                result = res.Succeeded;

            }

            return result;
        }
        public static bool Logout()
        {
            bool result = false;

            IdentityUser user = GetCurrentUser();

            if (user != null)
            {
                IAuthenticationManager authenticationManager = HttpContext.Current.GetOwinContext().Authentication;
                authenticationManager.SignOut(DefaultAuthenticationTypes.ApplicationCookie);
                result = true;
            }

            return result;
        }

        public static IdentityUser GetCurrentUser()
        {
            if (!IsLoggedIn())
                return null;
            ApplicationUserManager userManager = GetUserManager();

            IdentityUser currentUserId = userManager.FindById(GetCurrentUserId());
            return currentUserId;
        }

        public static string GetCurrentUserId()
        {
            //return "186a6dc9-4428-4ee4-9125-858a2a745d95";
            return HttpContext.Current.User.Identity.GetUserId();
        }


        public static bool IsLoggedIn()
        {
            return !string.IsNullOrEmpty(GetCurrentUserId());

        }

        public static void ConfirmEmail(string aspNetUserId)
        {
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.AspNetUsers_ConfirmEmail",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", aspNetUserId);
                }
                );
            return;
        }
        public LoginResponse Signin(string emailaddress, string password)
        {
            ApplicationUserManager userManager = GetUserManager();
            IAuthenticationManager authenticationManager = HttpContext.Current.GetOwinContext().Authentication;

            ApplicationUser user = userManager.Find(emailaddress, password);
            if (user == null)
            {
                return new LoginResponse()
                {
                    HasError = true,
                    Message = ("Incorrect Email or Password!")
                };
            }

            if (!user.EmailConfirmed)
            {
                return new LoginResponse()
                {
                    HasError = true,
                    Message = ("Your Email Has Not Been Confirmed! Please Check Your Inbox or Spam folder!")
                };

            }
            ClaimsIdentity signin = userManager.CreateIdentity(user, DefaultAuthenticationTypes.ApplicationCookie);
            authenticationManager.SignIn(new AuthenticationProperties() { IsPersistent = true }, signin);
            return new LoginResponse()
            {
                HasError = false

            };

        }

        public static string[] GetRoles()
        {
            if (GetCurrentUserId() != null){
                return GetUserManager().GetRoles(GetCurrentUserId()).ToArray();
            }
            return null;
        }
    }
}
    
