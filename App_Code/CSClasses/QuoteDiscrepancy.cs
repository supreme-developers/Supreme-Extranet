using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for QuoteDiscrepancy
/// </summary>
public class QuoteDiscrepancy
{
    public QuoteDiscrepancy()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public string QuoteNumber { get; set; }
    public string QuoteDate { get; set; }
    public string Customer { get; set; }
    public string JobType { get; set; }
    public string Item { get; set; }
    public string ItemDescription { get; set; }

    public string MinimumCode { get; set; }
    public string AddDayCode { get; set; }

    public Decimal QuoteMinimum { get; set; }
    public Decimal CatalogMinimum { get; set; }

    public Decimal QuoteAddDay { get; set; }
    public Decimal CatalogAddDay { get; set; }

    public string NotInPCBook { get; set; }
}