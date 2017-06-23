﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Domain
{
    public class LanguageProficiency
    {
        public string Key { get; set; } 
        public string Code { get; set; }
        public string Description { get; set; }
        public int DisplayOrder { get; set; }
        public string Name { get; set; }
       
        
        public bool Inactive { get; set; }
    }
}