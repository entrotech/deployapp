using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Domain
{
    public class ProjectPerson : ProjectPersonBase
    {       
        public PersonBase Person { get; set; }
    }
}