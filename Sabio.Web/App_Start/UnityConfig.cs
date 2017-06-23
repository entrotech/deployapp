using Microsoft.Practices.Unity;
using Sabio.Web.Requests;
using Sabio.Web.Requests.Interfaces;
using Sabio.Web.Services;
using System.Web.Http;
using System.Web.Mvc;
using Unity.Mvc5;

namespace Sabio.Web
{
    public static class UnityConfig
    {
        public static void RegisterComponents(HttpConfiguration config)
        {
            UnityContainer container = new UnityContainer();
            container.RegisterType<IServiceBranchService, ServiceBranchService>();
            container.RegisterType<IFaqService, FaqService>();
            container.RegisterType<IEmailService, Sabio.Web.Services.EmailService>();
            container.RegisterType<IGlobalEventService, GlobalEventService>();
            container.RegisterType<ISkillService, SkillService>();
            container.RegisterType<IInvoiceService, InvoiceService>();
            container.RegisterType<ISmsService, Sabio.Web.Services.SmsService>();
            container.RegisterType<ISquadService, SquadService>(new ContainerControlledLifetimeManager());
            container.RegisterType<ITestimonialService, TestimonialService>();
            container.RegisterType<ILanguageService, LanguageService>(new ContainerControlledLifetimeManager());
            container.RegisterType<ISquadTagService, SquadTagService>(new ContainerControlledLifetimeManager());
            container.RegisterType<ICompanyService, CompanyService>();
            container.RegisterType<IEducationLevelService, EducationLevelService>(new ContainerControlledLifetimeManager());
            container.RegisterType<IPersonService, PersonService>();
            container.RegisterType<IFileUploadService, FileUploadService>();
            container.RegisterType<IProjectsService, ProjectsService>(new ContainerControlledLifetimeManager());
            // register all your components with the container here
            // it is NOT necessary to register your controllers
            container.RegisterType<IBlogService, BlogServiceAdo>();
            // e.g. container.RegisterType<ITestService, TestService>();
            container.RegisterType<IJobTagService, JobTagService>();
            container.RegisterType<IJobPostingService, JobPostingService>();
            container.RegisterType<IJobPostingJobTagService, JobPostingJobTagService>();
            container.RegisterType<IAnnouncementService, AnnouncementService>(); // 3.  added this.  not add the interface name to the service.
            container.RegisterType<ISquadEventService, SquadEventService>();
            container.RegisterType<ICompanyPersonService, CompanyPersonService>();
            container.RegisterType<IJobApplicationService, JobApplicationService>();
            container.RegisterType<IAspNetUserRoleService, AspNetUserRoleService>();
            container.RegisterType<ITimecardEntryService, TimecardEntryService>();
            container.RegisterType<IOpportunityService, OpportunityService>();
            container.RegisterType<INotificationService, NotificationService>();
            container.RegisterType<IContactUsersService, ContactUsersService>();
            container.RegisterType<IHomeStatisticsService, HomeStatisticsService>();

            DependencyResolver.SetResolver(new UnityDependencyResolver(container));

            //  this line is needed so that the resolver can be used by api controllers
            config.DependencyResolver = new Sabio.Web.Core.Injection.UnityResolver(container);
        }
    }
}