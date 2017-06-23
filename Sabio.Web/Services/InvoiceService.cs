using Sabio.Data;
using Sabio.Web.Domain;
using Sabio.Web.Models.Requests;
using Sabio.Web.Models.Responses;
using Sabio.Web.Requests;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Sabio.Web.Services
{
    public class InvoiceService : BaseService, IInvoiceService
    {
        public int Insert(InvoiceAddRequest model)
        {
            int id = 0;

            DataProvider.ExecuteNonQuery(GetConnection, "dbo.Invoice_Insert",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    MapCommonParameters(model, paramCollection);

                    SqlParameter outputParam = new SqlParameter("@Id", SqlDbType.Int);
                    outputParam.Direction = ParameterDirection.Output;

                    paramCollection.Add(outputParam);
                }, returnParameters: delegate (SqlParameterCollection param)
                {
                    Int32.TryParse(param["@Id"].Value.ToString(), out id);
                }
                );
            return id;
        }

        public void Update(InvoiceUpdateRequest model)
        {
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.Invoice_Update",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", model.Id);
                    MapCommonParameters(model, paramCollection);
                }
                );

            return;
        }

        public void Delete(int id)
        {
            DataProvider.ExecuteNonQuery(GetConnection, "dbo.Invoice_Delete",
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", id);
                }
                );
        }




        private void MapCommonParameters(InvoiceAddRequest model, SqlParameterCollection paramCollection)
        {
            paramCollection.AddWithValue("@ProjectsId", model.ProjectsId);
            paramCollection.AddWithValue("@InvoiceDate", model.InvoiceDate);
            paramCollection.AddWithValue("@Description1", model.Description1);
            paramCollection.AddWithValue("@Description2", model.Description2);
            paramCollection.AddWithValue("LineTotal1", model.LineTotal1);
            paramCollection.AddWithValue("LineTotal2", model.LineTotal2);
            paramCollection.AddWithValue("@TimeCardTotals", model.TimeCardTotals);
            paramCollection.AddWithValue("@StatusId", model.StatusId);
        }
        private Invoice MapCommonParameters(IDataReader reader)
        {
            Invoice inv = new Invoice();
            int ord = 0;
            inv.ProjectsId = reader.GetSafeInt32(ord++);
            inv.InvoiceDate = reader.GetSafeDateTime(ord++);
            inv.StatusId = reader.GetSafeInt32(ord++);
            inv.Description1 = reader.GetSafeString(ord++);
            inv.Description2 = reader.GetSafeString(ord++);
            inv.LineTotal1 = reader.GetSafeDecimal(ord++);
            inv.LineTotal2 = reader.GetSafeDecimal(ord++);
            inv.TimeCardTotals = reader.GetSafeDecimal(ord++);


            return inv;
        }

    }

}








