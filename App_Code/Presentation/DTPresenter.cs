using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for DTPresenter
/// </summary>
public class DTPresenter
{
    private readonly DTRepository repository;
    private readonly DTDiscrepRepository dtDiscRepository;
    public DTPresenter()
    {
        this.repository = new DTRepository();
        this.dtDiscRepository = new DTDiscrepRepository();

    }
    public IEnumerable<DeliveryTicket> GetDTbyDTID(int DTID)
    {
        IEnumerable<DeliveryTicket> DT = this.repository.GetDTbyDTID(DTID);
        return DT;
    }
    public IEnumerable<DTDiscrepancy> GetDTDiscrepancy(int DTID)
    {
        IEnumerable<DTDiscrepancy> DTDiscrepancies = this.dtDiscRepository.GetDTDiscrepancy(DTID);
        return DTDiscrepancies;
    }
}