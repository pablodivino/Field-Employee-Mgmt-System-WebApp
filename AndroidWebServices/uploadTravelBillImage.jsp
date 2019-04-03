<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*,java.sql.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<%@ include file="../DBConnect.jsp"%>

<%
   File file ;
   int maxFileSize = 50000 * 1024;
   int maxMemSize = 50000 * 1024;
   ServletContext context = pageContext.getServletContext();
   String relativeWebPath = "/v0.3.4/Images/Travel_Bills";
   String absoluteDiskPath = getServletContext().getRealPath(relativeWebPath);
   String filePath = absoluteDiskPath;

   ArrayList<String> fName = new ArrayList<>();
   ArrayList<String> fVal = new ArrayList<>();

   // Verify the content type
   String contentType = request.getContentType();
   if ((contentType.indexOf("multipart/form-data") >= 0)) {

      DiskFileItemFactory factory = new DiskFileItemFactory();
      // maximum size that will be stored in memory
      factory.setSizeThreshold(maxMemSize);
      // Location to save data that is larger than maxMemSize.
      factory.setRepository(new File("E:\\APACHE TOMCAT\\webapps\\UploadTest\\images"));

      // Create a new file upload handler
      ServletFileUpload upload = new ServletFileUpload(factory);
      // maximum file size to be uploaded.
      upload.setSizeMax( maxFileSize );
      try{ 
         // Parse the request to get file items.
         List fileItems = upload.parseRequest(request);

         // Process the uploaded file items
         Iterator i = fileItems.iterator();

       //  out.println("<html>");
         //out.println("<head>");
         //out.println("<title>JSP File upload</title>");  
         //out.println("</head>");
         //out.println("<body>");
         while ( i.hasNext () ) 
         {
            FileItem fi = (FileItem)i.next();
            if ( !fi.isFormField () )	
            {
            // Get the uploaded file parameters
            String fieldName = fi.getFieldName();
            String fileName = fi.getName();
            boolean isInMemory = fi.isInMemory();
            long sizeInBytes = fi.getSize();
            // Write the file
            if( fileName.lastIndexOf("\\") >= 0 ){
            file = new File( filePath + 
            fileName.substring( fileName.lastIndexOf("\\"))) ;
            }else{
            file = new File( filePath + 
            fileName.substring(fileName.lastIndexOf("\\")+1)) ;
            }
            fi.write( file ) ;
            //out.println("Uploaded Filename: " + filePath + 
            //fileName + "<br>");
            }else{
                  fName.add(fi.getFieldName());
                  fVal.add(fi.getString());
            }
         }

         String TableFields = "`"+fName.get(0)+"`";
         String TableVals = "'"+fVal.get(0)+"'";

         for(int j=1;j<fName.size();j++){
         	TableFields += ",`"+fName.get(j)+"`";
         	TableVals += ",'"+fVal.get(j)+"'";
         }

         String insertQuery = "INSERT INTO `travel_cost`("+TableFields+") VALUES ("+TableVals+")";
		 PreparedStatement pstmt = con.prepareStatement(insertQuery, Statement.RETURN_GENERATED_KEYS);  
		pstmt.executeUpdate();
        out.println("Upload Successful");
      }catch(Exception ex) {
         out.println(ex);
      }
   }else{
		out.println("Something went wrong");
   }
%>

<%
	con.close();
%>