using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data.Sql;
using System.Configuration;
using System.Windows.Forms;


/// <summary>
/// Summary description for GlobalMethods
/// </summary>
public class GlobalMethods
{
  //public static string TimeClockConnectionString = "SSITimeClockMgrTest DevConnectionString"; //Test
   public static string TimeClockConnectionString = "SSITimeClockMgrConnectionString";
   public static string RentConnectionString = "SSIRentConnectionString";
   public static string RentDevConnectionString = "Rent DevConnectionString";

	public GlobalMethods()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public static Employee GetEmployee(string BadgeIDNumber)
    {
        
        Employee emp = new Employee();

        SqlConnection Dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings[TimeClockConnectionString].ToString());

        string cmdtext = "Select EmployeeID, DepartmentId,LastName,FirstName from tblEmployee where BadgeIDNumber = @BadgeIDNumber and Active = 1";
        SqlCommand cmd = new SqlCommand(cmdtext, Dbconn);
        cmd.Parameters.Add(new SqlParameter("@BadgeIDNumber", BadgeIDNumber)); 
        
        Dbconn.Open();
        SqlDataReader dr = cmd.ExecuteReader();

        try
        {
            if (dr.HasRows)
            {
                dr.Read();
                emp.EmployeeID = Convert.ToInt32(dr["EmployeeID"]);
                emp.DepartmentID = dr["DepartmentId"].ToString();
                emp.LastName = dr["LastName"].ToString();
                emp.FirstName = dr["FirstName"].ToString();
            }
            else
            {
                emp = null;
            }
        }
        catch (Exception ex)
        {
            string exception = ex.Message;
            return null;

        }
        finally
        {
            Dbconn.Close();
            Dbconn.Dispose();
            
        }
        return emp;
       
    }


    public static ItemObject GetItemInfo(string DTNumber,string itemNum)
    {
        ItemObject item = new ItemObject();
        string cmdText = "select top 1  H.JobTypeID, I.[Inventory ID], H.OfficeID From tblDelHeader H, tblInventory I where H.[Delivery Ticket Number] = @DTNumber and I.Item  = @ItemNum";
                         

        SqlConnection Dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings[RentConnectionString].ToString());
        SqlCommand cmd = new SqlCommand(cmdText, Dbconn);
        cmd.Parameters.Add(new SqlParameter("@DTNumber", DTNumber));
        cmd.Parameters.Add(new SqlParameter("@ItemNum", itemNum));
        Dbconn.Open();
        SqlDataReader dr = cmd.ExecuteReader();
        try
        {
            if (dr.HasRows)
            {
                dr.Read();
                item.itemExists = true;
                item.inventoryID = Convert.ToInt32(dr["JobTypeId"]);
                item.jobTypeID = Convert.ToInt32(dr["Inventory ID"]);
                item.officeID = Convert.ToInt32(dr["OfficeID"]);
                item.item = itemNum;
            }
            else
            {
                item.itemExists = false;
            }
        }

        catch (Exception ex)
        {
            string Ex = ex.Message;
           
        }

        finally
        {
            Dbconn.Close();
            Dbconn.Dispose();

        }

        return item;
    }

    public static DeviceCheckOutObject GetCheckoutInfo(string myName) 
    {
        DeviceCheckOutObject deviceCheckout = new DeviceCheckOutObject();
        string cmdtext = "select D.Device_CodeID,D.Document,D.HREmployeeID,e.FirstName + ' ' + e.LastName as Name," +
                         " D.Work_Status, D.Checkout_DateTime,D.Checkin_DateTime,D.Work_TypeID" +
                         " From tblInventory I inner join tblMobile_DeviceAssignment D on I.[Inventory ID] = D.Device_CodeID  " +
                         " inner join tblHREmployee E on D.HREmployeeID = E.EmployeeID " +
                         " where I.Item = @DeviceName and D.AssignmentID = (select MAX(AssignmentID) from tblMobile_DeviceAssignment where Device_CodeID = D.Device_CodeID)";
        SqlConnection Dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings[RentConnectionString].ToString());
        SqlCommand cmd = new SqlCommand(cmdtext, Dbconn);
        cmd.Parameters.Add(new SqlParameter("@DeviceName", myName));
        Dbconn.Open();
        SqlDataReader dr = cmd.ExecuteReader();
        try
        {
            if (dr.HasRows)
            {
                dr.Read();
                if (Convert.IsDBNull(dr["Checkin_DateTime"]))
                    deviceCheckout.checkinTime = null;
                else
                    deviceCheckout.checkinTime =  Convert.ToDateTime(dr["Checkin_DateTime"]);

                deviceCheckout = new DeviceCheckOutObject(Convert.ToInt32(dr["Device_CodeID"]), dr["Document"].ToString(), Convert.ToInt32(dr["HrEmployeeID"]), dr["Name"].ToString(),
                                                                               dr["Work_Status"].ToString(), Convert.ToDateTime(dr["Checkout_DateTime"]), deviceCheckout.checkinTime, Convert.ToInt32(dr["Work_TypeID"]));
            }
        }  
        catch (Exception ex)
        {
            string exception = ex.Message;           
            MessageBox.Show(exception);
        }
        finally
        {
            Dbconn.Close();
            Dbconn.Dispose();
        }

        return deviceCheckout;
       
    }

    public static String PassUTCriteriaCheck(ItemObject item)
    {
        string cmdtext = "sp_DT_PassUTCriteriaCheck @InvID, @JobTypeId";

        SqlConnection Dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings[RentConnectionString].ToString());
        SqlCommand cmd = new SqlCommand(cmdtext, Dbconn);
        cmd.Parameters.Add(new SqlParameter("@InvID", item.inventoryID));
        cmd.Parameters.Add(new SqlParameter("@JobTypeId", item.jobTypeID));
        Dbconn.Open();
        try
        {
            cmd.ExecuteNonQuery();
            return "Passed";
        }
        catch(Exception ex)
        {
            string exception = ex.Message;
            MessageBox.Show(exception);
            return ex.Message;
            
        }        
    }

    public static ItemObject JobPostCheck(ItemObject item, string DTNumber)
    {
        ItemObject returnItem = new ItemObject();

        returnItem = item;
        string cmdtext = "sp_DT_ItemJobPostCheck @ItemNum, @DTNumber, @OfficeID";

        SqlConnection Dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings[RentConnectionString].ToString());
        SqlCommand cmd = new SqlCommand(cmdtext, Dbconn);
        cmd.Parameters.Add(new SqlParameter("@ItemNum", item.item));
        cmd.Parameters.Add(new SqlParameter("@DTNumber", DTNumber));
        cmd.Parameters.Add(new SqlParameter("@OfficeID", item.officeID));
        Dbconn.Open();
       
        try
        {
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                dr.Read();
                 if (Convert.ToInt32(dr["PutOnDT"]) == 0)
                 {
                     returnItem.verdict = "NoError";
                 }
                 else if (Convert.ToInt32(dr["PutOnDT"]) == 1)
                 {
                     returnItem.verdict = "Warning";
                     returnItem.verdictMessage = dr["ErrorMessage"].ToString();
                 }
                 else if (Convert.ToInt32(dr["PutOnDT"]) == 2)
                 {
                     returnItem.verdict = "Error";
                     returnItem.verdictMessage = dr["ErrorMessage"].ToString();
                 }

            }
            return returnItem;
            
        }
        catch (Exception ex)
        {
            returnItem.verdict = "Error";
            returnItem.verdictMessage = ex.Message;
            return returnItem;
        }
        finally
        {
            Dbconn.Close();
            Dbconn.Dispose();
        }
    }

    public static void DTAddItem(string DTNumber,ItemObject item, int quantity,long userID)
    {

        string cmdtext = "sp_DTAddItem @DeliveryTicketNumber,@Item_Num,@Quantity,@UserID";
        SqlConnection Dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings[RentConnectionString].ToString());
        SqlCommand cmd = new SqlCommand(cmdtext, Dbconn);
        cmd.Parameters.Add(new SqlParameter("@DeliveryTicketNumber", DTNumber));
        cmd.Parameters.Add(new SqlParameter("@Item_Num", item.item));
        cmd.Parameters.Add(new SqlParameter("@Quantity", quantity));
        cmd.Parameters.Add(new SqlParameter("@UserID", userID));

        Dbconn.Open();

        try
        {
            cmd.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            string exception = ex.Message;
            MessageBox.Show(exception);

        }
        finally
        {
            Dbconn.Close();
            Dbconn.Dispose();
        }
       
    }

    public static void InsertTimeCard(String Type,TimeClockObject timeclock)  
    {
        string cmdtext = "";    
        int punchtype = 0;
        SqlConnection Dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings["SSITimeClockMgrConnectionString"].ToString());
        SqlCommand cmd = new SqlCommand(cmdtext, Dbconn);
        if (Type == "I")
        {
         punchtype = 1;   

        }
        else if(Type == "O")
        {
            punchtype = 2;
        }
            
            cmdtext = "sp_ClockInOut @employeeId,@PunchType,@DateIn,@Timein,@Dateout,@Timeout";
            
           cmd.CommandText = cmdtext;
            cmd.Parameters.Add(new SqlParameter("@employeeId", timeclock.EmployeeID));
            cmd.Parameters.Add(new SqlParameter("@PunchType", punchtype));

        if (timeclock.Datein != null)
        {
          cmd.Parameters.Add(new SqlParameter("@DateIn", timeclock.Datein));
          cmd.Parameters.Add(new SqlParameter("@Timein", timeclock.Timein));
        }
        else
        {
            cmd.Parameters.Add(new SqlParameter("@DateIn", DBNull.Value));
            cmd.Parameters.Add(new SqlParameter("@Timein", DBNull.Value));
        }

        if (timeclock.Dateout != null)
        {
            cmd.Parameters.Add(new SqlParameter("@DateOut", timeclock.Dateout));
            cmd.Parameters.Add(new SqlParameter("@Timeout", timeclock.Timeout));
        }
        else
        {
            cmd.Parameters.Add(new SqlParameter("@DateOut", DBNull.Value));
            cmd.Parameters.Add(new SqlParameter("@Timeout", DBNull.Value));
        }
           
        
        Dbconn.Open();

        try
        {
            cmd.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            string exception = ex.Message;
            
        }
        finally
        {
            Dbconn.Close();
            Dbconn.Dispose();
        }
    }

    public static TimeClockObject GetLatestPunchTime(int EmpID)
    {
        TimeClockObject timeclock = new TimeClockObject();
        string cmdtext = "Select TimeIn,Timeout from tblTimeCard" +
                         " where TimeCardID = (Select Max(TimeCardID) from tblTimeCard where" +
                         " EmployeeID = @EmployeeID)";
        SqlConnection Dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings[TimeClockConnectionString].ToString());
        SqlCommand cmd = new SqlCommand(cmdtext, Dbconn);
        cmd.Parameters.Add(new SqlParameter("@EmployeeID", EmpID));
        Dbconn.Open();
        SqlDataReader dr = cmd.ExecuteReader();
        try
        {
            if (dr.HasRows)
            {
                dr.Read();
                if (dr[0].ToString() != "")
                    timeclock.Timein = dr.GetTimeSpan(dr.GetOrdinal("TimeIn"));
                if (dr[1].ToString() != "")
                    timeclock.Timeout = dr.GetTimeSpan(dr.GetOrdinal("Timeout"));                
            }
        }
        catch (Exception ex)
        {
            string exception = ex.Message;
        }
        finally
        {
            Dbconn.Close();
            Dbconn.Dispose();
        }
        return timeclock;
    }

    public static bool IsClockedin(int EmpID)
    {

        string cmdtext = "Select TimeCardID from tbltimeCard Where TimeCardId = (Select Max(TimeCardID) from tbltimeCard " +
                         " Where EmployeeID = @EmployeeID And DateOut Is Null) and TimeOut IS NULL And Timein IS NOT NULL ";
        SqlConnection Dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings["SSITimeClockMgrConnectionString"].ToString());
        SqlCommand cmd = new SqlCommand(cmdtext, Dbconn);
        cmd.Parameters.Add(new SqlParameter("@EmployeeID", EmpID));
        Dbconn.Open();
        SqlDataReader dr = cmd.ExecuteReader();
        try
        {
            if (dr.HasRows)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        catch (Exception ex)
        {
            string msg = ex.Message;
            return false;
        }
        finally
        {
            Dbconn.Close();
            Dbconn.Dispose();
        }
    }
    public static long GetUserID(string WinAdName)
    {
        if (WinAdName.Contains("SUPREME\\"))
        {
            WinAdName = WinAdName.Replace("SUPREME\\", "");
        }
        
        string cmdText = "Select UserID From usysPasswords Where WinADName = @WinAdName";
        SqlConnection Dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings[RentConnectionString].ToString());
        SqlCommand cmd = new SqlCommand(cmdText, Dbconn);
        cmd.Parameters.Add(new SqlParameter("@WinAdName", WinAdName));
        Dbconn.Open();
        int userID = Convert.ToInt32(cmd.ExecuteScalar());

        return userID;

    }
    public static Dictionary<int, String> GetTopFolders(long UserID)
    {
        Dictionary<int, string> folderList = new Dictionary<int,string>();
        string cmdText = "select Distinct f.FolderID, F.FolderName  from tblsys_menuchoices M" +
                         "  left join tblSys_MenuFolders F on M.FolderID = F.FolderID " +
                         "  left join tblSys_MenuChoice_Group_Matrix GM on M.MenuChoiceID = GM.MenuChoiceID" +
                         "  left join tblSys_Group_User_Matrix GUM on GM.GroupID = GUM.GroupID " +
                         "  where F.SubOfID = 0 and GUM.UserID = @User " +
                         "  group by f.FolderID, f.FolderName, M.MenuChoiceID, M.MenuChoiceDescription ";

        SqlConnection Dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings[RentConnectionString].ToString());
        SqlCommand cmd = new SqlCommand(cmdText, Dbconn);
        cmd.Parameters.Add(new SqlParameter("@User", UserID));
        Dbconn.Open();
        SqlDataReader dr = cmd.ExecuteReader();

        try
        {
            while (dr.Read())
            {
                folderList.Add(Convert.ToInt32(dr["FolderID"]), dr["FolderName"].ToString());
            }            
        }

        catch (Exception ex)
        {
            string Ex = ex.Message;
        }

        finally
        {
            Dbconn.Close();
            Dbconn.Dispose();
            
        }

        return folderList;

    }
    public static List<MenuDetailFolder> GetDetailFolders(long UserID)
    {
        List<MenuDetailFolder> folderList = new List<MenuDetailFolder>();
        string cmdText = "select Distinct f.FolderID, F.FolderName, f.SubOfID,f.SortOrder,F1.FolderName as aboveFolder  from tblsys_menuchoices M" +
                         "  left join tblSys_MenuFolders F on M.FolderID = F.FolderID " +
                         "  left join tblSys_MenuChoice_Group_Matrix GM on M.MenuChoiceID = GM.MenuChoiceID" +
                         "  left join tblSys_Group_User_Matrix GUM on GM.GroupID = GUM.GroupID " +
                         " left join tblSys_MenuFolders F1 on f.SubOfID = F1.FolderID " +
                         "  where F.SubOfID != 0 and GUM.UserID = @User and f.Web is null  " +
                         "  group by f.SubofID,f.FolderID, f.FolderName,f.SortOrder, F1.FolderName" +
                         "  order by F.SubOfID";

        SqlConnection Dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings[RentConnectionString].ToString());
        SqlCommand cmd = new SqlCommand(cmdText, Dbconn);
        cmd.Parameters.Add(new SqlParameter("@User", UserID));
        Dbconn.Open();
        SqlDataReader dr = cmd.ExecuteReader();

        try
        {
            while (dr.Read())
            {
                MenuDetailFolder folder = new MenuDetailFolder(Convert.ToInt32(dr["FolderID"]),dr["FolderName"].ToString(),Convert.ToInt32(dr["SubOfID"]),Convert.ToInt32(dr["SortOrder"]), dr["aboveFolder"].ToString());
                folderList.Add(folder);
            }
        }

        catch (Exception ex)
        {
            string Ex = ex.Message;
        }

        finally
        {
            Dbconn.Close();
            Dbconn.Dispose();

        }

        return folderList;

    }
 
    public static Guid RetrieveGUID()
    {
        Guid guid;

        try
        {
            string cmdtext = "SELECT GUID FROM ##temptblReportParmeters WHERE ReportID = 1";
            SqlConnection Dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings[RentConnectionString].ToString());
            SqlCommand cmd = new SqlCommand(cmdtext, Dbconn);
            Dbconn.Open();
            guid = (Guid)cmd.ExecuteScalar();
        }
        catch(Exception ex)
        {
            throw new Exception(ex.Message);
        }

        return guid;

    }

    public static String GetSysFlagValue(string FlagDesc)
    {
        string cmdtext = "select FlagValue from tblsys_flags where FlagDescription = @FlagDescription";

        SqlConnection Dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings[RentConnectionString].ToString());
        SqlCommand cmd = new SqlCommand(cmdtext, Dbconn);
        cmd.Parameters.Add(new SqlParameter("@FlagDescription", FlagDesc));       
        Dbconn.Open();
        try
        {
            return cmd.ExecuteScalar().ToString();
            
        }
        catch (Exception ex)
        {
            string exception = ex.Message;
            MessageBox.Show(exception);
            return ex.Message;

        }        
    }


}