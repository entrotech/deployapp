﻿using Sabio.Web.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Models.Requests
{
    public class ExDaveUpdateRequest: ExDaveAddRequest

    {
        public int Id { get; set; }
    }
}