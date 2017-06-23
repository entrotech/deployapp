using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Sabio.Web.Requests.Interfaces
{
    public interface ISquadService
    {
        int Insert(SquadAddRequest model);
        void Update(SquadUpdateRequest model);
        void Delete(int id);
        Squad SelectById(int id);
        List<Squad> SelectAll();

        List<PersonBase> PersonBaseSearch(PersonSearchRequest model, out int rows);
        List<Squad> Search(SquadSearchRequest model);
    }
}