using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Employee
/// </summary>
public class Employee
{
    private int _EmployeeID;
    private String _EmployeeNumber;
    private String _LastName;
    private String _FirstName;
    private String _BadgeIDNumber;
    private String _EmployeeType;
    private String _DepartmentID;
    private int _Active;
    private String _CompID;
    private int _EmployeeTypeID;

	public Employee()
	{
		
	}
    public Employee(int EmployeeId, String EmployeeNumber,String LastName, String FirstName, String BadgeIDNumber,String EmployeeType,
                     String DepartmentID, int Active, String CompID, int EmployeeTypeID)
    {
        this._EmployeeID = EmployeeId;
        this._EmployeeNumber = EmployeeNumber;
        this._LastName = LastName;
        this._FirstName = FirstName;
        this._BadgeIDNumber = BadgeIDNumber;
        this._EmployeeType = EmployeeType;
        this._DepartmentID = DepartmentID;
        this._Active = Active;
        this._CompID = CompID;
        this._EmployeeTypeID = EmployeeTypeID;

    }
    
    #region Public Properties
    public int EmployeeID { get { return _EmployeeID; } set { _EmployeeID = value; } }
    public String EmployeeNumber { get { return _EmployeeNumber; } set { _EmployeeNumber = value; } }
    public String LastName { get { return _LastName; } set { _LastName = value; } }
    public String FirstName { get { return _FirstName; } set { _FirstName = value; } }
    public String BadgeIDNumber { get { return _BadgeIDNumber; } set { _BadgeIDNumber = value; } }
    public String EmployeeType { get { return _EmployeeType; } set { _EmployeeType = value; } }    
    public String DepartmentID { get { return _DepartmentID; } set { _DepartmentID = value; } }
    public int Active { get { return _Active; } set { _Active = value; } }
    public String CompID { get { return _CompID; } set { _CompID = value; } }
    public int EmployeeTypeID { get { return _EmployeeTypeID; } set { _EmployeeTypeID = value; } }  
    #endregion
}