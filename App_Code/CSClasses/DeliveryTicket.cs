using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for DeliveryTicket
/// </summary>
public class DeliveryTicket
{
    public DeliveryTicket()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public string DTNumber { get; set; }
    public string ItemDescription { get; set; }
    public string Dispatcher { get; set; }
    public string InvoiceTo { get; set; }
    public string OrderedBy { get; set; }
    public string PONumber { get; set; }
    public string JobNumber { get; set; }
    public string OrderNumber { get; set; }
    public string DeliveryDate { get; set; }
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
    public List<DeliveryTicket> Items { get; set; }
    public Boolean HasDisrepancy { get; set; }
    public int QuotePriceBook { get; set; }
    public string AlternateCustomerNumber { get; set; }
    public string AlternateJobType { get; set; }
    public string Salesmen { get; set; }
    public Boolean AddOn { get; set; }
}