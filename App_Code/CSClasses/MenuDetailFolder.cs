using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for MenuDetailFolder
/// </summary>
public class MenuDetailFolder
{
    #region Private Variables

    private int _FolderID;
    private string _FolderName;
    private int _SubOfID;
    private int _SortOrder;
    private string _aboveFolder;

    #endregion
	public MenuDetailFolder()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public MenuDetailFolder(int FolderID, string FolderName, int SubOfID, int SortOrder, string aboveFolder)
    {
        this._FolderID = FolderID;
        this._FolderName = FolderName;
        this._SubOfID = SubOfID;
        this._SortOrder = SortOrder;
        this._aboveFolder = aboveFolder; 
    }


    #region Public Properties
        public int FolderID { get { return _FolderID; } set { _FolderID = value; } }
        public string FolderName { get { return _FolderName; } set { _FolderName = value; } }
        public int SubofID { get { return _SubOfID; } set { _SubOfID = value; } }
        public int SortOrder { get { return _SortOrder; } set { _SortOrder = value; } }
        public string aboveFolder { get { return _aboveFolder; } set { _aboveFolder = value; } }
    #endregion
}