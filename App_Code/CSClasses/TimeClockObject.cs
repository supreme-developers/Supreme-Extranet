using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for TimeClock
/// </summary>
public class TimeClockObject
{
    #region Private Variables
        
        private int _EmployeeID;
        private int _PunchType;
        private DateTime? _Datein;
        private TimeSpan? _Timein;
        private DateTime? _Dateout;
        private TimeSpan? _Timeout;
        private int? _PayTypeID;
        private String _DepartmentID;        
        private int? _TimeCardID;
        private int? _UserID;
        private int? _PayWeekID;
        private String _TCNote;
        private int? _UnVerify;
        
    #endregion

        #region Constructors
        public TimeClockObject()
        {
            
        }

        public TimeClockObject(int EmployeeID, int PunchType, DateTime? Datein, TimeSpan? Timein, DateTime? Dateout, TimeSpan? Timeout, int PayTypeID, 
                               String DepartmentID, int? TimeCardID, int? UserID,int? PayWeekID, String TCNote, int UnVerify)
        {
            this._EmployeeID = EmployeeID;
            this._PunchType = PunchType;
            this._Datein = Datein;
            this._Timein = Timein;
            this._Dateout = Dateout;
            this._Timeout = Timeout;
            this._PayTypeID = PayTypeID;
            this._DepartmentID = DepartmentID;
            this._TimeCardID = TimeCardID;
            this._UserID = UserID;
            this._PayWeekID = PayWeekID;
            this._TCNote = TCNote;
            this._UnVerify = UnVerify;
        }
        #endregion
    #region Public Properties
        public int EmployeeID { get { return _EmployeeID; } set { _EmployeeID = value; } }
        public int PunchType { get { return _PunchType; } set { _PunchType = value; } }
        public DateTime? Datein { get { return _Datein; } set { _Datein = value; } }
        public TimeSpan? Timein { get { return _Timein; } set { _Timein = value; } }
        public DateTime? Dateout { get { return _Dateout; } set { _Dateout = value; } }
        public TimeSpan? Timeout { get { return _Timeout; } set { _Timeout = value; } }
        public int? PayTypeID { get { return _PayTypeID; } set { _PayTypeID = value; } }
        public String DepartmentID { get { return _DepartmentID; } set { _DepartmentID = value; } }
        public int? TimeCardID { get { return _TimeCardID; } set { _TimeCardID = value; } }
        public int? UserID { get { return _UserID; } set { _UserID = value; } }
        public int? PayWeekID { get { return _PayWeekID; } set { _PayWeekID = value; } }
        public String TCNote { get { return _TCNote; } set { _TCNote = value; } }
        public int? UnVerify { get { return _UnVerify; } set { _UnVerify = value; } }
    #endregion

}