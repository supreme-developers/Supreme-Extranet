Imports Microsoft.VisualBasic
Imports System.Data.SqlClient

Public Class WebFunctions
    Private strSQLConnect As String
    Private strSupreme As String = "supreme\"

    Public Property SQLConnect() As String
        Get
            SQLConnect = strSQLConnect
        End Get
        Set(ByVal value As String)
            strSQLConnect = value
        End Set
    End Property

    Public Function GetSOPUserID(ByVal UserName As String) As Long

        Dim cn As New SqlConnection(strSQLConnect)
        cn.Open()
        Dim cmd As New SqlCommand
        cmd.Connection = cn

        Dim strUserName As String
        strUserName = Right(UserName, Len(UserName) - Len(strSupreme))

        cmd.CommandText = "Select UserID From usysPasswords Where WinADName = '" & strUserName & "'"
        Dim rdr As SqlDataReader
        rdr = cmd.ExecuteReader

        If Not rdr.Read Then
            Return 0
        Else
            Return rdr("UserID")
        End If

        rdr = Nothing
        cmd = Nothing
        cn = Nothing

   
    End Function
End Class
