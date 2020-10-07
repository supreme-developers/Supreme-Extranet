using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

/// <summary>
/// Summary description for QuoteRepository
/// </summary>
public class QuoteRepository : QuoteObject
{
    public QuoteRepository()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public IEnumerable<QuoteObject> GetQuote(int QuoteHeaderID)
    {
        var quotes = new List<QuoteObject>();
        using (var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["SSIRentConnectionString"].ConnectionString))
        using (SqlCommand command = connection.CreateCommand())
        {
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "sp_Quotes_rptQuote";
            command.Parameters.AddWithValue("@QuoteHeaderID", QuoteHeaderID);
            command.Connection.Open();

            using (SqlDataReader dr = command.ExecuteReader())
            {
                while (dr.Read())
                {
                    var quote = new QuoteObject
                    {
                        Number = dr["QuoteNumber"].ToString(),
                        Date = dr["QuoteDate"].ToString(),
                        Status = dr["ApprovalStatus"].ToString(),
                        Type = dr["ClassificationType"].ToString(),
                        ItemDescription = dr["ItemDescription"].ToString(),
                        OrderedBy = dr["Ordered by"].ToString(),
                        Dispatcher = dr["Name"].ToString(),
                        PONumber = dr["PONumber"].ToString(),
                        JobNumber = dr["JobNumber"].ToString(),
                        OrderNumber = dr["OrderNumber"].ToString(),
                        InvoiceTo = dr["Customer"].ToString(),
                        ShipVia = dr["ShipVia"].ToString(),
                        ShipTo = dr["Shipto"].ToString(),
                        Lease = dr["LeaseOCSG"].ToString(),
                        AFE = dr["AFE"].ToString(),
                        Area = dr["AreaBlock"].ToString(),
                        RigNum = dr["RigNo"].ToString(),
                        WellNum = dr["WellNo"].ToString(),
                        State = dr["State"].ToString(),
                        Parish = dr["Parish"].ToString(),
                        JobType = dr["JobType"].ToString(),
                        Contractor = dr["Contractor"].ToString(),
                        Quantity = dr["Quantity"] == DBNull.Value ? 0 : Convert.ToInt32(dr["Quantity"]),                        
                        MinRentalDays = dr["MinimumRentalDays"] == DBNull.Value ? 0 : Convert.ToInt32(dr["MinimumRentalDays"]),
                        NetAddDay = dr["NetAddDay"] == DBNull.Value ? 0 : Convert.ToDouble(dr["NetAddDay"]),
                        NetMin = dr["NetMin"] == DBNull.Value ? 0 : Convert.ToDouble(dr["NetMin"]),
                        DiscountRate = (Math.Round(Convert.ToDecimal(dr["DiscountRate"]), 2) * 100).ToString() + "%",
                        EstimatedDays = dr["EstimatedDays"] == DBNull.Value ? 0 : Convert.ToInt32(dr["EstimatedDays"]),
                        EstimatedDaysRental = dr["EstimatedDaysRental"] == DBNull.Value ? 0 : Convert.ToDouble(dr["EstimatedDaysRental"]),
                        CalculateEstimatedDays = Convert.ToBoolean(dr["CalculateEstimatedDays"]),
                        CreateUserID = Convert.ToInt32(dr["CreateUserID"]),
                        QuotePriceBook = Convert.ToInt32(dr["QuotePriceBook"]),
                        AlternateCustomerNumber = dr["AlternateCustomerNumber"].ToString(),
                        AlternateJobType = dr["AlternateJobType"].ToString(),
                        HasDiscrepancyReport = dr["HasDiscrepancyReport"] == DBNull.Value ? false : Convert.ToBoolean(dr["HasDiscrepancyReport"]),
                        Salesmen = GetSalesmen(QuoteHeaderID),
                        Revision = dr["RevisionCount"].ToString()
                    };

                    quotes.Add(quote);
                }
            }

            return quotes;


        }

    }

    public string GetSalesmen(int QuoteHeaderID)
    {
        string salesmen = "";
        using (var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["SSIRentConnectionString"].ConnectionString))
        using (SqlCommand command = connection.CreateCommand())
        {
            command.CommandType = CommandType.Text;
            command.CommandText = "select Distinct u.FirstName + ' ' + LastName as Name From tblquotes_salesreps s " +
                                  "  inner join usyspasswords U on s.userid = u.userid " +
                                  " where s.QuoteID = @QuoteHeaderID" +
                                  "  order by u.FirstName + ' ' + LastName";
            command.Parameters.AddWithValue("@QuoteHeaderID", QuoteHeaderID);
            command.Connection.Open();

            using (SqlDataReader dr = command.ExecuteReader())
            {
                while (dr.Read())
                {
                    salesmen = salesmen + dr["Name"].ToString() + ",";
                }
            }
        }
        return salesmen;
    }
    public string ApproveReject(int QuoteHeaderID, int UserID, string Note, string Action)
    {
        string sp = "";
        string error = "";
        if (Action == "Approve")
            sp = "sp_Quotes_Approval";
        if (Action == "Reject")
            sp = "sp_Quotes_Deny";


        using (var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["SSIRentConnectionString"].ConnectionString))
        using (SqlCommand command = connection.CreateCommand())
        {
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = sp;
            command.Parameters.AddWithValue("@QuoteID", QuoteHeaderID);
            command.Parameters.AddWithValue("@UserID", UserID);
            if (Note != "")
                command.Parameters.AddWithValue("@Note", Note);
            else
                command.Parameters.AddWithValue("@Note", DBNull.Value);

            command.Connection.Open();
            try {
                command.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                error = "There was a problem trying to " + Action + " the Quote. Please contact IT with the following message: <br>" + ex.Message;
            }
            finally
            {
                command.Connection.Close();
                command.Connection.Dispose();
            }
        }
        return error;
    }

    public void DiscrepancyAcknowledgement (int QuoteHeaderID, int UserID)
    {
        using (var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["SSIRentConnectionString"].ConnectionString))
        using (SqlCommand command = connection.CreateCommand())
        {
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "sp_Quotes_AcknowledgeDiscrepancy";
            command.Parameters.AddWithValue("@QuoteHeaderID", QuoteHeaderID);
            command.Parameters.AddWithValue("@UserID", UserID);
            command.Connection.Open();
            try
            {
                command.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            finally
            {
                command.Connection.Close();
                command.Connection.Dispose();
            }
        }
    }
}