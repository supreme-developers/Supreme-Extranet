using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for QuotePresenter
/// </summary>
/// 

public class QuotePresenter
{
    private readonly QuoteRepository repository;
    private readonly QuoteDiscrepRepository discrepancyRepository;
    public QuotePresenter()
    {
        this.repository = new QuoteRepository();
        this.discrepancyRepository = new QuoteDiscrepRepository();
    }
    public IEnumerable<QuoteObject> GetQuotebyID(int QuoteHeaderID)
    {
        //QuoteRepository repository = new QuoteRepository();
        IEnumerable<QuoteObject> quotes = this.repository.GetQuote(QuoteHeaderID);
        return quotes;
    }

    public IEnumerable<QuoteDiscrepancy> GetQuoteDiscrepancy(int QuoteHeaderID)
    {
        IEnumerable<QuoteDiscrepancy> quoteDiscrepancies = this.discrepancyRepository.GetQuoteDiscrepancy(QuoteHeaderID);
        return quoteDiscrepancies;
    }
   

}