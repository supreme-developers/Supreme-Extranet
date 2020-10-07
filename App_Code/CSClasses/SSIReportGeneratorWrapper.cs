using System;
using System.Linq;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.ComponentModel;
using System.Collections.Generic;
using System.Configuration;

using SSIReportEngine;
namespace SSIReportEngine
{
   
    public class SSIReportGeneratorWrapper
    {
        public bool reportclosed = false;
        private bool showformdialog = false;
        

        protected List<SqlParameter> pList = new List<SqlParameter>();

        public void AddParameter(string name,string value)
        {
            SqlParameter p = new SqlParameter(name, LoadValue(value));
            pList.Add(p);
        }

        public void AddParameter(string name, Int16 value)
        {
            SqlParameter p = new SqlParameter(name, value);
            pList.Add(p);
        }

        public void AddParameter(string name, Int32 value)
        {
            SqlParameter p = new SqlParameter(name, value);
            pList.Add(p);
        }

        public void AddParameter(string name, Int64 value)
        {
            SqlParameter p = new SqlParameter(name, value);
            pList.Add(p);
        }

        public void AddParameter(string name, Single value)
        {
            SqlParameter p = new SqlParameter(name,value);
            pList.Add(p);
        }


        private object LoadValue(string value)
        {
            if (!string.IsNullOrEmpty(value))
            {
                return value;
            }
            return DBNull.Value;
        }

        public void RunReportOld(string database, string server, string reportname, Int64 id)
        {
            //GenerateReport(database, server,reportname,Convert.ToInt32(id));
        }
        //public bool RunReport(bool showdialog, ReportViewer rptViewer)
        //{
        //    showformdialog = showdialog;
        //    //GenerateReport(rptViewer);
        //    return reportclosed;
        //}

        public Guid GenerateReport()
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["SSIRentConnectionString"].ToString());
            SqlCommand command = connection.CreateCommand();
            CreateConnection(command, connection);
            CreateTempTable(pList);
            Guid guid = RetrieveGUID(command);            
            InsertSQLParameters(pList, guid, command);
           // GenerateForm(rptViewer);
            command.Connection.Close();
            return guid;
        }

        public static void CreateTempTable(List<SqlParameter> parameters)
        {
            SqlConnection Dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings["SSIRentConnectionString"].ToString());
            SqlCommand command = new SqlCommand("", Dbconn);
            Dbconn.Open();
            try
            {
                command.CommandText = "DROP TABLE ##temptblReportParmeters";
                command.ExecuteNonQuery();
            }
            catch
            { }
            command.CommandText = "CREATE TABLE ##temptblReportParmeters ([GUID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_tblReportsParameters_GUID]  DEFAULT (newid()), [ReportID] int not null CONSTRAINT [PK_##temptblReportParmeters] PRIMARY KEY CLUSTERED ([GUID] ASC))";
            command.ExecuteNonQuery();
            try
            {
                foreach (SqlParameter p in parameters)
                {
                    command.CommandText = "SELECT SSIReportParamType FROM [SSIRent].[dbo].[tblSYS_SSIReports_Parameters] Where SSIReportParamName = @parameter";

                    command.Parameters.AddWithValue("@parameter", p.ParameterName);
                    var parameterType = command.ExecuteScalar();

                    command.CommandText = "ALTER TABLE ##temptblReportParmeters ADD " + p.ParameterName + "  " + parameterType.ToString();
                    command.ExecuteNonQuery();
                    command.Parameters.RemoveAt(0);

                }

                command.CommandText = "Insert Into ##temptblReportParmeters(ReportID) Values(1)";
                command.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message.ToString());
            }
            finally
            {
                Dbconn.Close();
                Dbconn.Dispose();
            }

        }


        private void InsertSQLParameters(List<SqlParameter> parameters, Guid guid, SqlCommand command)
        {
            //SqlConnection Dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings["SSIRentConnectionString"].ToString());
           // SqlCommand command = new SqlCommand("", Dbconn);
            try
            {
                
                foreach (SqlParameter p in parameters)
                {         
                    command.CommandText = "UPDATE ##temptblReportParmeters SET " + p.ParameterName + " = @Parameter Where GUID = @guidParameter";
                    command.Parameters.AddWithValue("Parameter", p.Value);
                    command.Parameters.AddWithValue("@guidParameter", guid);
                    command.ExecuteNonQuery();
                    command.Parameters.RemoveAt("Parameter");
                    command.Parameters.RemoveAt("@guidParameter");
                }
            }
            catch
            {
                throw new Exception("Table could not be updated.");
            }
           
        }

        private Guid RetrieveGUID(SqlCommand command)
        {
            Guid guid;
                try
                {
                  command.CommandText = "SELECT GUID FROM ##temptblReportParmeters WHERE ReportID = 1";
                  guid = (Guid)command.ExecuteScalar();
                }
                catch
                {
                  throw new Exception("GUID was not found.");
                }

            return guid;

        }

        private void CreateConnection(SqlCommand command, SqlConnection connection)
        {
            command.Connection = connection;
            command.CommandType = CommandType.Text;
            command.Connection.Open();
                        
        }

        private void CloseConnection(SqlCommand command, SqlConnection connection)
        {
            command.Connection.Close();
        }

        //private void GenerateForm(ReportViewer rptViewer)
        //{
        //    ReportViewer form = new ReportViewer("no name", guid, id);

        //  //  form.Text = "Supreme Services Report Viewer - " + GetReportDisplayName(reportname, connection);
        //    if (showformdialog)
        //    {
        //        form.ShowDialog();
        //        reportclosed = form.closeform;
        //    }
        //    else
        //    {
        //        form.Show();
        //    }
        //}

        private string GetReportDisplayName(string reportname, SqlConnection connection)
        {
            SqlCommand command = new SqlCommand();
            string value = string.Empty;

            command.Connection = connection;
            command.CommandType = CommandType.Text;
            //command.Connection.Open();
            command.CommandText = "SELECT [SSIReportDisplayName] FROM [SSIRent].[dbo].[tblSYS_SSIReports] Where SSIReportName = @displayname";
            command.Parameters.AddWithValue("@displayname", reportname);
            return value = command.ExecuteScalar().ToString();
        }    
    } 
}