using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ItemObject
/// </summary>
public class ItemObject
{
    private string _Item;
    private int _InventoryId;
    private int _JobTypeID;
    private string _Description;
    private int _OfficeID;
    private int _OfficeDivisionID;
    private bool _ItemExists;
    private String _Verdict;
    private String _VerdictMessage;

         #region Constructors
	public ItemObject()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public ItemObject(string item, int inventoryID, string description, int officeID, int officeDivisionId, int jobTypeID, bool ItemExists, String verdict, String verdictMessage)
        {
            this._Item = item;
            this._InventoryId = inventoryID;
            this._Description = description;
            this._OfficeID = officeID;
            this._OfficeDivisionID = officeDivisionId;
            this._JobTypeID = jobTypeID;
            this._ItemExists = ItemExists;
            this._Verdict = verdict;
            this._VerdictMessage = verdictMessage;
        }
        #endregion
    #region Public Properties
        public string item { get { return _Item; } set { _Item = value; } }
        public int inventoryID { get { return _InventoryId; } set { _InventoryId = value; } }
        public string description { get { return _Description; } set { _Description = value; } }
        public int officeID { get { return _OfficeID; } set { _OfficeID = value; } }
        public int officeDivisionId { get { return _OfficeDivisionID; } set { _OfficeDivisionID = value; } }
        public int jobTypeID { get { return _JobTypeID; } set { _JobTypeID = value; } }
        public bool itemExists { get { return _ItemExists; } set { _ItemExists = value; } }
        public String verdict { get { return _Verdict; } set { _Verdict = value; } }
        public String verdictMessage { get { return _VerdictMessage; } set { _VerdictMessage = value; } }
    #endregion
}