﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Models.Requests
{
    public class ContactRequestSearchRequest
    {
        public string SearchString { get; set; }

        public int CurrentPage { get; set; }

        public int ItemsPerPage { get; set; }
    }
}