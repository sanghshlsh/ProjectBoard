package kr.co.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class BoardDAO {

		private DataSource dataFactory;
		
		public BoardDAO() {
			try {
				Context ctx = new InitialContext();
				dataFactory = (DataSource) ctx.lookup("java:comp/env/jdbc/oracle11g");
			} catch (NamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		private void closeAll(Connection conn, PreparedStatement pstmt, ResultSet rs) {
			try {
				
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
}
