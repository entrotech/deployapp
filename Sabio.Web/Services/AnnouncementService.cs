using Sabio.Data;
using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;
using Sabio.Web.Requests;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace Sabio.Web.Services
{
    public class AnnouncementService : BaseService, IAnnouncementService  // 2.  Add interface name here "IAnnouncementService".
    {
        public int Insert(AnnouncementAddRequest model)
        {
            int id = 0;

            DataProvider.ExecuteNonQuery(GetConnection, "dbo.Announcement_Insert"
               , inputParamMapper: delegate (SqlParameterCollection paramCollection)
               {
                   MapCommonParameters(model, paramCollection);

                   SqlParameter p = new SqlParameter("@id", System.Data.SqlDbType.Int);
                   p.Direction = System.Data.ParameterDirection.Output;

                   paramCollection.Add(p);

               }, returnParameters: delegate (SqlParameterCollection param)
               {
                   int.TryParse(param["@id"].Value.ToString(), out id);
               }
               );

            return id;
        }

        public void Update(AnnouncementUpdateRequest model)
        {
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.Announcement_Update",
            inputParamMapper: delegate (SqlParameterCollection paramCollection)
            {
                paramCollection.AddWithValue("@id", model.Id);
                MapCommonParameters(model, paramCollection);
            }
            );

            return;
        }

        public void ImageUpload(string photoKey, int id)
        {
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.Announcement_ImageUpload",
            inputParamMapper: delegate (SqlParameterCollection paramCollection)
            {
                paramCollection.AddWithValue("@id", id);
                paramCollection.AddWithValue("@photoKey", photoKey);
            }
            );

            return;
        }

        public void Delete(int id)
        {
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.Announcement_Delete",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {   
                    paramCollection.AddWithValue("@id", id);
                }
            );

            return;
        }

        public void DeleteImage(int id)
        {
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.Announcement_DeleteImage",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@id", id);
                }
            );

            return;
        }

        public Announcement SelectById(int id)
        {
            Announcement announcement = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.Announcement_SelectById",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@id", id);
                }
                , map: delegate (IDataReader reader, short set)
                {
                    switch (set)
                    {
                        case 0:
                            announcement = MapAnnouncement(reader);
                            break;
                    }
                }
            );

            return announcement;
        }

        public List<Announcement> SelectAll()
        {
            List<Announcement> list = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.Announcement_SelectAll"
               , inputParamMapper: null
               , map: delegate (IDataReader reader, short set)
               {
                   switch (set)
                   {
                       case 0:
                           Announcement announcement = MapAnnouncement(reader);

                           if (list == null)
                           {
                               list = new List<Announcement>();
                           }

                           list.Add(announcement);
                           break;
                   }
               }
            );

            return list;
        }

        public AnnouncementAndCategory SelectAllAnnouncementsAndCategories()
        {
            List<Announcement> list = null;

            List<AnnouncementCategoryTotal> ctList = null;

            DataProvider.ExecuteCmd(GetConnection, "dbo.AnnouncementAndCategory_SelectAll"
               , inputParamMapper: null
               , map: delegate (IDataReader reader, short set)
               {
                   switch (set)
                   {
                       case 0:
                           AnnouncementCategoryTotal annCatTotal = MapCategoryTotal(reader);

                           if (ctList == null)
                           {
                               ctList = new List<AnnouncementCategoryTotal>();
                           }

                           ctList.Add(annCatTotal);
                           break;
                       case 1:
                           Announcement announcement = MapAnnouncement(reader);

                           if (list == null)
                           {
                               list = new List<Announcement>();
                           }

                           list.Add(announcement);
                           break;
                   }
               }
            );

            return new AnnouncementAndCategory {
                CategoriesWithTotals = ctList,
                Announcements = list
            };
        }

        private AnnouncementCategoryTotal MapCategoryTotal(IDataReader reader)
        {
            AnnouncementCategoryTotal catTotal = new AnnouncementCategoryTotal();

            int ord = 0;

            catTotal.CategoryTotal = reader.GetSafeInt32(ord++);
            catTotal.AnnouncementCategoryId = reader.GetSafeInt32(ord++);
            catTotal.CategoryName = reader.GetSafeString(ord++);

            return catTotal;
        }

        private void MapCommonParameters(AnnouncementAddRequest model, SqlParameterCollection paramCollection)
        {
            paramCollection.AddWithValue("@title", model.Title);
            paramCollection.AddWithValue("@announcementCategoryId", model.AnnouncementCategoryId);
            paramCollection.AddWithValue("@body", model.Body);
            paramCollection.AddWithValue("@userId", UserService.GetCurrentUserId());
        }

        private Announcement MapAnnouncement(IDataReader reader)
        {
            Announcement announcement = new Announcement();
            int ord = 0;

            announcement.Id = reader.GetSafeInt32(ord++);
            announcement.PersonId = reader.GetSafeInt32(ord++);
            announcement.Title = reader.GetSafeString(ord++);
            announcement.Body = reader.GetSafeString(ord++);
            AnnouncementCategory cat = new AnnouncementCategory();
            cat.Id = reader.GetSafeInt32(ord++);
            cat.Name = reader.GetSafeString(ord++);
            announcement.AnnouncementCategory = cat;
            announcement.DateCreated = reader.GetSafeDateTime(ord++);
            announcement.PersonFirstName = reader.GetSafeString(ord++);
            announcement.PersonLastName = reader.GetSafeString(ord++);
            announcement.PhotoKey = reader.GetSafeString(ord++);
            return announcement;
        }
    }
} 