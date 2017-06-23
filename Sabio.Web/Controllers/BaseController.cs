using Sabio.Web.Domain;
using Sabio.Web.Models.ViewModels;
using Sabio.Web.Requests;
using Sabio.Web.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Sabio.Web.Controllers
{
    public class BaseController : Controller
    {
        public new ViewResult View()
        {
            BaseViewModel model = GetViewModel<BaseViewModel>();
            DecorateViewModel(model);
            return base.View(model);
        }

        public new ViewResult View(string viewString)
        {
            BaseViewModel model = GetViewModel<BaseViewModel>();
            DecorateViewModel(model);
            return base.View(viewString, model); //is this viewString supposed to be the name of the view to rendered? What's the use for this method?
        }

        public ViewResult View(BaseViewModel baseVM)

        {
            if (baseVM != null)
            {
                baseVM = DecorateViewModel<BaseViewModel>(baseVM);
            }
            return base.View(baseVM);
        }

        public ViewResult View(string viewString, BaseViewModel baseVM)
        {
            if (baseVM != null)
            {
                baseVM = DecorateViewModel<BaseViewModel>(baseVM);
            }
            return base.View(viewString, baseVM);
        }

        //Strongly Typed Layout Views
        //Sabio.layout.model to move out to layout
        protected T GetViewModel<T>() where T : BaseViewModel, new()
        {
            T model = new T();
            return DecorateViewModel(model);
        }

        protected T DecorateViewModel<T>(T model) where T : BaseViewModel
        {

            //the below method checks if the user is logged in when it gets their UserId 
            string aspNetUserId = UserService.GetCurrentUserId();
            if (!string.IsNullOrEmpty(aspNetUserId))
            {
                model.IsLoggedIn = true;

                IPersonService _personService = new PersonService();
                PersonLayout person = _personService.GetByAspNetUserId(aspNetUserId);

                model.FirstName = person.FirstName;
                model.MiddleName = person.MiddleName;
                model.LastName = person.LastName;
                model.UserPhoneNumber = person.PhoneNumber;
                model.UserEmail = person.Email;
                model.Id = person.Id;
                model.projects = person.Projects;
                model.TimecardEntry = person.TimecardEntry;
                model.Roles = UserService.GetRoles();
            }
            return model;
        }

    }
}