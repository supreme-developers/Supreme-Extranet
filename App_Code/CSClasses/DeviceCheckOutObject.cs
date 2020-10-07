using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for DeviceCheckOutObject
/// </summary>
public class DeviceCheckOutObject
{
    private int _DeviceId;
    private string _JobID;
    private int _EmployeeID;
    private string _EmployeeName;
    private string _Status;
    private DateTime? _CheckoutTime;
    private DateTime? _CheckinTime;
    private int _WorkTypeID;

    #region Constructors
    public DeviceCheckOutObject()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public DeviceCheckOutObject(int deviceID, string jobID, int employeeID, string employeeName, string status, DateTime? checkoutTime, DateTime? checkinTime, int workType)
    {
        this._DeviceId = deviceID;
        this._JobID = jobID;
        this._EmployeeID = employeeID;
        this._EmployeeName = employeeName;
        this._Status = status;
        this._CheckoutTime = checkoutTime;
        this._CheckinTime = checkinTime;
        this._WorkTypeID = workType;
    }
    #endregion

    #region Public Properties

    public int deviceID { get { return _DeviceId; } set { _DeviceId = value; } }
    public string jobID { get { return _JobID; } set { _JobID = value; } }
    public int employeeID { get { return _EmployeeID; } set { _EmployeeID = value; } }
    public string employeeName { get { return _EmployeeName; } set { _EmployeeName = value; } }
    public string status { get { return _Status; } set { _Status = value; } }
    public DateTime? checkoutTime { get { return _CheckoutTime; } set { _CheckoutTime = value; } }
    public DateTime? checkinTime { get { return _CheckinTime; } set { _CheckinTime = value; } }
    public int workType { get { return _WorkTypeID; } set { _WorkTypeID = value; } }

    #endregion


}