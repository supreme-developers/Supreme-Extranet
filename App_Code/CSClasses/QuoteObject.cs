using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Quote
/// </summary>
public class QuoteObject
{
   
    public QuoteObject()
    {
       // this.Quantity = null;
       // this.MinRentalDays = null;
       //this.AddDay = null;
       //this.Minimum = null;
       //this.Discount = null;
       // this.EstimatedDays = 0;
       //this.TypeTotal = null;
       //this.EstimatedDaysRental = 0;
}
    public string Number { get; set; }
    public string Date { get; set; }
    public string Status { get; set; }
    public string Type { get; set; }
    public string ItemDescription { get; set; }
    public string OrderedBy { get; set; }
    public string Dispatcher { get; set; }
    public string PONumber { get; set; }
    public string JobNumber { get; set; }
    public string OrderNumber { get; set; }
    public string InvoiceTo { get; set; }
    public string ShipVia { get; set; }
    public string ShipTo { get; set; }
    public string Lease { get; set; }
    public string AFE { get; set; }
    public string Area { get; set; }
    public string RigNum { get; set; }
    public string WellNum { get; set; }
    public string State { get; set; }
    public string Parish { get; set; }
    public string JobType { get; set; }
    public string Contractor { get; set; }
    public int? Quantity { get; set; }
    public int? MinRentalDays { get; set; }
    public Double? NetAddDay { get; set; }
    public Double? NetMin { get; set; }
    public string DiscountRate { get; set; }
    public int? EstimatedDays { get; set; }
    public Decimal? TypeTotal { get; set; }
    public Double? EstimatedDaysRental { get; set; }
    public Boolean CalculateEstimatedDays { get; set; }
    public List<QuoteObject> Items { get; set; }
    public int CreateUserID { get; set; }
    public int QuotePriceBook { get; set; }
    public string AlternateCustomerNumber { get; set; }
    public string AlternateJobType { get; set; }
    public Boolean HasDiscrepancyReport { get; set; }
    public string Salesmen { get; set; }
    public string Revision { get; set; }

}