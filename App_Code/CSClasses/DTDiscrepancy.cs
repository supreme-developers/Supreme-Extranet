using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for DTDiscrepancy
/// </summary>
public class DTDiscrepancy
{
    public DTDiscrepancy()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public string DTNumber { get; set; }
    public string InvoiceNumber { get; set; }
    public string QuoteNumber { get; set; }
    public string DiscrepancyType { get; set; }
    public string Code { get; set; }
    public string ItemDescription { get; set; }
    public int Quantity { get; set; }
    public int QuoteQuantity { get; set; }
    public Decimal Minimum { get; set; }
    public Decimal AddDay { get; set; }
    public Decimal QuoteMinimum { get; set; }
    public Decimal QuoteAddDay { get; set; }

    public Boolean PrintColumn { get; set; }
}