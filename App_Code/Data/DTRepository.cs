using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

/// <summary>
/// Summary description for DTRepository
/// </summary>
public class DTRepository: DeliveryTicket
{
    public DTRepository()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public IEnumerable<DeliveryTicket> GetDTbyDTID(int DTID)
    {
        var DTs = new List<DeliveryTicket>();
        using (var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["SSIRentConnectionString"].ConnectionString))
        using (SqlCommand command = connection.CreateCommand())
        {
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "sp_DT_rptDeliveryTicket";
            command.Parameters.AddWithValue("@DTID", DTID);
            command.Connection.Open();
            try
            {
                using (SqlDataReader dr = command.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        var DT = new DeliveryTicket
                        {
                            DTNumber = dr["Delivery Ticket"].ToString(),
                            DeliveryDate = dr["Delivery Date"].ToString(),
                            ItemDescription = dr["Item Description"].ToString(),
                            OrderedBy = dr["Ordered by"].ToString(),
                            Dispatcher = dr["Dispatcher"].ToString(),
                            PONumber = dr["PO Number"].ToString(),
                            JobNumber = dr["Job Number"].ToString(),
                            OrderNumber = dr["Order Number"].ToString(),
                            InvoiceTo = dr["Invoice To"].ToString(),
                            ShipVia = dr["Ship Via"].ToString(),
                            ShipTo = dr["Ship to"].ToString(),
                            Lease = dr["Lease/OCSG"].ToString(),
                            AFE = dr["AFE#"].ToString(),
                            Area = dr["Area/Block"].ToString(),
                            RigNum = dr["Rig#"].ToString(),
                            WellNum = dr["Well#"].ToString(),
                            State = dr["State"].ToString(),
                            Parish = dr["Parish"].ToString(),
                            JobType = dr["Job Type"].ToString(),
                            Contractor = dr["Contractor"].ToString(),
                            Quantity = Convert.ToInt32(dr["Quantity"]),
                            MinRentalDays = dr["Minimum Rental Days"] == DBNull.Value ? 0 : Convert.ToInt32(dr["Minimum Rental Days"]),
                            NetAddDay = dr["Additional Day"] == DBNull.Value ? 0 : Convert.ToDouble(dr["Additional Day"]),
                            NetMin = dr["Minimum"] == DBNull.Value ? 0 : Convert.ToDouble(dr["Minimum"]),
                            HasDisrepancy = dr["HasDiscrepancy"] == DBNull.Value ? false : Convert.ToBoolean(dr["HasDiscrepancy"]),
                            QuotePriceBook = Convert.ToInt32(dr["Quote Price Book"]),
                            AlternateCustomerNumber = dr["AlternateCustomerNumber"].ToString(),
                            AlternateJobType = dr["AlternateJobType"].ToString(),
                            AddOn = dr["AddOn"] == DBNull.Value ? false : Convert.ToBoolean(dr["AddOn"])
                            //DiscountRate = (Math.Round(Convert.ToDecimal(dr["DiscountRate"]), 2) * 100).ToString() + "%",
                            //EstimatedDays = dr["EstimatedDays"] == DBNull.Value ? 0 : Convert.ToInt32(dr["EstimatedDays"]),
                            //EstimatedDaysRental = dr["EstimatedDaysRental"] == DBNull.Value ? 0 : Convert.ToDouble(dr["EstimatedDaysRental"]),
                            //CalculateEstimatedDays = Convert.ToBoolean(dr["CalculateEstimatedDays"]),
                            //CreateUserID = Convert.ToInt32(dr["CreateUserID"]),

                            //  HasDiscrepancyReport = dr["HasDiscrepancyReport"] == DBNull.Value ? false : Convert.ToBoolean(dr["HasDiscrepancyReport"])
                        };

                        DTs.Add(DT);
                    }
                }
            }
            catch(Exception ex)
            {
                Console.WriteLine(ex.InnerException);
            }

            return DTs;


        }

    }

}