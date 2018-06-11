<%-- 
    Document   : index
    Created on : Jun 10, 2018, 9:34:24 PM
    Author     : murphy
--%>

<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.Reader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStream"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <script src="https://unpkg.com/ag-grid/dist/ag-grid.min.noStyle.js"></script>
  <link rel="stylesheet" href="https://unpkg.com/ag-grid/dist/styles/ag-grid.css">
  <link rel="stylesheet" href="https://unpkg.com/ag-grid/dist/styles/ag-theme-balham.css">
  <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">
  
</head>
<body style="padding: 100px;">

  <h1>Traackr Exercise</h1>

  <form action="index.jsp" method="post" target="_self"
            enctype="multipart/form-data">

    <div class="row">
        <div class="col-lg-4 col-lg-offset-4">
            <div class="input-group">
                 File 1:<input type="file" class="form-control-file" id="inputData1" name="inputData1"/>
            </div>
        </div>
    </div>
    File 2:<input type="file" class="form-control-file center" id="inputData2" name="inputData2"/>
    <hr/>
    <input class="btn btn-primary" type="submit" value="Submit">
    <input class="btn btn-primary" type="reset" value="Reset">
    </center>
</form>
    <%
    
    boolean isMultipart = ServletFileUpload.isMultipartContent(request);
        // Create a factory for disk-based file items
    if(isMultipart){
    DiskFileItemFactory factory = new DiskFileItemFactory();

    // Configure a repository (to ensure a secure temp location is used)
    ServletContext servletContext = this.getServletConfig().getServletContext();
    File repository = (File) servletContext.getAttribute("javax.servlet.context.tempdir");
    factory.setRepository(repository);

    // Create a new file upload handler
    ServletFileUpload upload = new ServletFileUpload(factory);

    // Parse the request
    List<FileItem> items = upload.parseRequest(request);
    if(items.size()==2)
    {
    %>    
          <div id="myGrid" style="height: 600px;width:800px;" class="ag-theme-balham"></div>

    <script type="text/javascript" charset="utf-8">
      // specify the columns
      var columnDefs = [
        {headerName: "Type", field: "type", editable: false},
        {headerName: "Date", field: "date", editable: false},
        {headerName: "Description", field: "desc", editable: false},
        {headerName: "Amount", field: "amount", editable: false}
      ];
      var rowData = [
    <%    
    
        FileItem fi = items.get(0);
        InputStream sr = fi.getInputStream();
        InputStreamReader nr = new InputStreamReader(sr);
        BufferedReader br = new BufferedReader(nr);
        String tmp = br.readLine();
        Boolean isFirst = true;
        if(tmp!=null)
            tmp=br.readLine();
        while(tmp != null){
            String arr[] = tmp.split(",");
            if(!isFirst){
                out.print(",");
            }
            else
            {
             isFirst = false;           
            }
            %>
                    {type: "<%=arr[0]%>", date: "<%=arr[1]%>", desc:"<%=arr[4]%>", amount:"<%=arr[5]%>" }
            <%
            tmp = br.readLine();

            }
    %>

    
    // specify the data
    
      //{code: "BR", description: "Brand"},
      //{code: "PP", description: "Product Promotion"},
      //{code: "PR", description: "Product Retention"}
    ];
    
    // let the grid know which columns and what data to use
    var gridOptions = {
      columnDefs: columnDefs,
      rowData: rowData,     
      enableSorting: true,
      enableFilter: true,
      animateRows: true
    };

  // lookup the container we want the Grid to use
  var eGridDiv = document.querySelector('#myGrid');

  // create the grid passing in the div to use together with the columns & data we want to use
  new agGrid.Grid(eGridDiv, gridOptions);

  </script>
  <%
  }
    }
    
  
%>
</center>
</body>