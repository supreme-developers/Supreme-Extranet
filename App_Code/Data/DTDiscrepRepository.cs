using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

/// <summary>
/// Summary description for DTDiscrepRepository
/// </summary>
public class DTDiscrepRepository:DTDiscrepancy
{
    public DTDiscrepRepository()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public IEnumerable<DTDiscrepancy> GetDTDiscrepancy(int DTID)
    {
        var DTDiscrepancies = new List<DTDiscrepancy>();
        using (var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["SSIRentConnectionString"].ConnectionString))
        using (SqlCommand command = connection.CreateCommand())
        {
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "sp_dt_rptdtinvcquotediscrepancy";
            command.Parameters.AddWithValue("@DTID", DTID);
            command.Parameters.AddWithValue("@DT", 1);
            command.Connection.Open();

            using (SqlDataReader dr = command.ExecuteReader())
            {
                while (dr.Read())
                {
                    var DTDiscrepancy = new DTDiscrepancy
                    {
                        DTNumber = dr["DeliveryTicketNumber"].ToString(),
                        ItemDescription = dr["Description"].ToString(),
                        QuoteNumber = dr["QuoteNumber"].ToString(),
                        InvoiceNumber = dr["InvoiceNumber"].ToString(),
                        Code = dr["Code"].ToString(),
                        Quantity = Convert.ToInt32(dr["Quantity"]),
                        QuoteQuantity = Convert.ToInt32(dr["QQuantity"]),
                        AddDay = dr["Additional Day"] == DBNull.Value ? 0 : Convert.ToDecimal(dr["Additional Day"]),
                        QuoteAddDay = dr["QAddDay"] == DBNull.Value ? 0 : Convert.ToDecimal(dr["QAddDay"]),
                        Minimum = dr["Minimum"] == DBNull.Value ? 0 : Convert.ToDecimal(dr["Minimum"]),
                        QuoteMinimum = dr["QMinimum"] == DBNull.Value ? 0 : Convert.ToDecimal(dr["QMinimum"]),
                        DiscrepancyType = dr["DiscrepancyType"].ToString(),
                        PrintColumn = dr["Minimum"] == DBNull.Value ? false : Convert.ToBoolean(dr["PrintColumn"])

                    };

                    DTDiscrepancies.Add(DTDiscrepancy);
                }
            }

            return DTDiscrepancies;


        }

    }
}