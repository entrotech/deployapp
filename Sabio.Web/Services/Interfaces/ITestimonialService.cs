using System.Collections.Generic;
using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;

namespace Sabio.Web.Requests.Interfaces
{
    public interface ITestimonialService
    {
        void Delete(int id);
        int Post(TestimonialAddRequest model);
        List<Testimonial> SelectAll();
        Testimonial SelectById(int id);
        void Update(TestimonialUpdateRequest model);
        List<Testimonial> Search(TestimonialSearchRequest model);

    }
}