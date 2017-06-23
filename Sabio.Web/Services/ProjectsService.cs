using Sabio.Web.Domain;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using Sabio.Data;
using Sabio.Web.Models.Requests;
using Sabio.Web.Requests;
using Sabio.Web.Models;

namespace Sabio.Web.Services
{

    public class ProjectsService : BaseService, IProjectsService
    {

        public int Post(ProjectsAddRequest model)
        {
            int id = 0;

            DataProvider.ExecuteNonQuery(GetConnection, "dbo.Project_Insert"
               , inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   MapCommonParameters(model, paramCollection);

                   SqlParameter p = new SqlParameter("@Id", SqlDbType.Int);
                   p.Direction = ParameterDirection.Output;

                   paramCollection.Add(p);

               }, returnParameters: delegate (SqlParameterCollection param)
               {
                   int.TryParse(param["@Id"].Value.ToString(), out id);
               }
               );


            return id;
        }


        public void Update(ProjectsUpdateRequest model)
        {
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.Project_Update",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", model.Id);
                    paramCollection.AddWithValue("@TrelloBoardId", model.TrelloBoardId);
                    paramCollection.AddWithValue("@TrelloBoardUrl", model.TrelloBoardUrl);
                    MapCommonParameters(model, paramCollection);
                }
                );

            return;
        }

        private static void MapCommonParameters(ProjectsAddRequest model, SqlParameterCollection paramCollection)
        {
            paramCollection.AddWithValue("@ProjectName", model.ProjectName);
            paramCollection.AddWithValue("@Description", model.Description);
            paramCollection.AddWithValue("@Budget", model.Budget);
            paramCollection.AddWithValue("@Deadline", model.Deadline);
            paramCollection.AddWithValue("@CompanyId", model.CompanyId);
            paramCollection.AddWithValue("@UserIdCreated", UserService.GetCurrentUserId());
        }

        public void Delete(int id)
        {
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.Project_Delete",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", id);

                }
                );

            return;
        }


        public List<Project> SelectAll()
        {
            List<Project> list = null;


            DataProvider.ExecuteCmd(GetConnection, "dbo.Project_SelectAll"
               , inputParamMapper: null
               , map: delegate (IDataReader reader, short set)
               {

                   switch (set)
                   {
                       case 0:
                           Project p = new Project();
                           int startingIndex = 0;


                           p.Id = reader.GetSafeInt32(startingIndex++);
                           p.ProjectName = reader.GetSafeString(startingIndex++);
                           p.Description = reader.GetSafeString(startingIndex++);
                           p.Budget = reader.GetSafeDecimal(startingIndex++);
                           p.Deadline = reader.GetSafeDateTime(startingIndex++);
                           p.DateCreated = reader.GetSafeDateTime(startingIndex++);
                           p.DateModified = reader.GetSafeDateTime(startingIndex++);
                           p.ProjectStatusId = reader.GetSafeInt32(startingIndex++);
                           p.Status = reader.GetSafeString(startingIndex++);
                           p.CompanyId = reader.GetSafeInt32(startingIndex++);
                           p.AmountToDate = reader.GetSafeDecimal(startingIndex++);
                           if (list == null)
                           {
                               list = new List<Project>();
                           }

                           list.Add(p);
                           break;

                       case 1:

                           ProjectPerson pp = new ProjectPerson();
                           int ord = 0;
                           int projectId = reader.GetSafeInt32(ord++);
                           pp.Person = new PersonBase();
                           pp.Person.Id = reader.GetSafeInt32(ord++);
                           pp.IsLeader = reader.GetSafeBool(ord++);
                           pp.StatusId = reader.GetSafeInt32(ord++);
                           pp.ProjectPersonStatus = reader.GetSafeString(ord++);
                           
                           pp.Person.FirstName = reader.GetSafeString(ord++);
                           pp.Person.LastName = reader.GetSafeString(ord++);
                           pp.Person.PhoneNumber = reader.GetSafeString(ord++);
                           pp.Person.Email = reader.GetSafeString(ord++);

                           Project parentProject = list.Find(x => x.Id == projectId);
                           if (parentProject.Staff == null)
                           {
                               parentProject.Staff = new List<ProjectPerson>();
                           }
                           parentProject.Staff.Add(pp);

                           break;

                   }


               }
            );


            return list;
        }

        public Project SelectById(int id)
        {
            Project p = null;
            List<Project> list = null;


            DataProvider.ExecuteCmd(GetConnection, "dbo.Project_SelectById",
               inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   paramCollection.AddWithValue("@Id", id);
               }
               , map: delegate (IDataReader reader, short set)
               {
                   int startingIndex = 0; //startingOrdinal

                   switch (set)
                   {

                       case 0:

                           p = new Project();

                           p.Id = reader.GetSafeInt32(startingIndex++);
                           p.ProjectName = reader.GetSafeString(startingIndex++);
                           p.Description = reader.GetSafeString(startingIndex++);
                           p.Budget = reader.GetSafeDecimalNullable(startingIndex++);
                           p.Deadline = reader.GetSafeDateTimeNullable(startingIndex++);
                           p.DateCreated = reader.GetSafeDateTime(startingIndex++);
                           p.DateModified = reader.GetSafeDateTime(startingIndex++);
                           p.ProjectStatusId = reader.GetSafeInt32(startingIndex++);
                           p.Status = reader.GetSafeString(startingIndex++);
                           p.CompanyId = reader.GetSafeInt32(startingIndex++);
                           p.AmountToDate = reader.GetSafeDecimal(startingIndex++);
                           p.TrelloBoardId = reader.GetSafeString(startingIndex++);
                           p.TrelloBoardUrl = reader.GetSafeString(startingIndex++);
                           if (list == null)
                           {
                               list = new List<Project>();
                           }

                           list.Add(p);

                           break;

                       case 1:


                           ProjectPerson pp = new ProjectPerson();
                           int ord = 0;
                           int projectId = reader.GetSafeInt32(ord++);
                           pp.Person = new PersonBase();
                           pp.Person.Id = reader.GetSafeInt32(ord++);
                           pp.IsLeader = reader.GetSafeBool(ord++);
                           pp.StatusId = reader.GetSafeInt32(ord++);
                           pp.ProjectPersonStatus = reader.GetSafeString(ord++);
                           pp.Person.FirstName = reader.GetSafeString(ord++);
                           pp.Person.LastName = reader.GetSafeString(ord++);
                           pp.Person.PhoneNumber = reader.GetSafeString(ord++);
                           pp.Person.Email = reader.GetSafeString(ord++);
                           pp.Person.PhotoKey = reader.GetSafeString(ord++);
                           pp.HourlyRate = reader.GetSafeDecimal(ord++);

                           Project parentProject = list.Find(x => x.Id == projectId);
                           if (parentProject.Staff == null)
                           {
                               parentProject.Staff = new List<ProjectPerson>();
                           }
                           parentProject.Staff.Add(pp);


                           break;
                   }


               }
               );

            return p;
        }

        public List<Project> SelectProjectByCompanyId(int id)
        {
            List<Project> list = new List<Project>();

            DataProvider.ExecuteCmd(GetConnection, "dbo.Project_SelectByCompanyId",
               inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   paramCollection.AddWithValue("@CompanyId", id);

               }
               , map: delegate (IDataReader reader, short set)
               {
                   MapProjectCompanyParameters(reader, list);
               }
               );

            return list;
        }

        private static void MapProjectCompanyParameters(IDataReader reader, List<Project> list)
        {
            Project project = new Project();
            int ord = 0; //startingOrdinal

            project.Id = reader.GetSafeInt32(ord++);
            project.ProjectName = reader.GetSafeString(ord++);
            
            list.Add(project);
        }

        
    }

}