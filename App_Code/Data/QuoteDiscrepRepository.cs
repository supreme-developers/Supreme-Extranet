using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

/// <summary>
/// Summary description for QuoteDiscrepRepository
/// </summary>
public class QuoteDiscrepRepository : QuoteDiscrepancy
{
    public QuoteDiscrepRepository()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public IEnumerable<QuoteDiscrepancy> GetQuoteDiscrepancy(int QuoteHeaderID)
    {
        var quoteDiscreps = new List<QuoteDiscrepancy>();
        using (var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["SSIRentConnectionString"].ConnectionString))
        using (SqlCommand command = connection.CreateCommand())
        {
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "sp_Quotes_rptPriceDiscrepancy";
            command.Parameters.AddWithValue("@QuoteID", QuoteHeaderID);
            command.Connection.Open();

            using (SqlDataReader dr = command.ExecuteReader())
            {
                while (dr.Read())
                {
                    var quoteDiscr = new QuoteDiscrepancy
                    {
                        QuoteNumber = dr["QuoteNumber"].ToString(),
                        QuoteDate = dr["QuoteDate"].ToString(),
                        Customer = dr["Customer Name"].ToString(),
                        JobType = dr["Job Type"].ToString(),
                        Item = dr["Item"].ToString(),
                        ItemDescription = dr["ItemDescription"].ToString(),
                        MinimumCode = dr["MinCode"].ToString(),
                        AddDayCode = dr["AddDayCode"].ToString(),
                        QuoteMinimum = dr["MinAmt"] == DBNull.Value ? 0 : Convert.ToDecimal(dr["MinAmt"]),
                        CatalogMinimum = dr["CatalogMinAmt"] == DBNull.Value ? 0 : Convert.ToDecimal(dr["CatalogMinAmt"]),
                        QuoteAddDay = dr["AddDay"] == DBNull.Value ? 0 : Convert.ToDecimal(dr["AddDay"]),
                        CatalogAddDay = dr["CatalogAddDay"] == DBNull.Value ? 0 : Convert.ToDecimal(dr["CatalogAddDay"]),
                        NotInPCBook = dr["NotInPCBook"].ToString()
                    };

                    quoteDiscreps.Add(quoteDiscr);
                }
            }

            return quoteDiscreps;


        }

    }
}