﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sabio.Web.Domain
{
    public class Invoice
    {
        public int Id { get; set; }
        public int ProjectsId { get; set; }
        public DateTime InvoiceDate { get; set; }
        public string Description1 { get; set; }
        public string Description2 { get; set; }
        public decimal LineTotal1 { get; set; }
        public decimal LineTotal2 { get; set; }
        public decimal TimeCardTotals { get; set; }
        public int StatusId { get; set; }
    }
}