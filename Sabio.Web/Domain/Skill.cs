﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Domain
{
    public class Skill
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Code { get; set; }
        public int DisplayOrder { get; set; }
    }
}
