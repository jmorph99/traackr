<%-- 
    Document   : index
    Created on : Jun 10, 2018, 9:34:24 PM
    Author     : murphy
--%>

<%@page import="java.util.stream.IntStream"%>
<%@page import="java.util.Random"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.Reader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="com.murphy.addToHast"%>
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
                 Data File:<input type="file" class="form-control-file" id="inputData1" name="inputData1"/>
            </div>
        </div>
    </div>
     
    Number of modified results:<input type="text" class="form-control" id="numModified" name="numModified" value="25"/>
    <input class="btn btn-primary" type="submit" value="Submit">
    <input class="btn btn-primary" type="reset" value="Reset">
    </center>
</form>
    <%
    String modifiesCount;
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
        
        modifiesCount = items.get(1).getString();
        HashMap<String, Integer> first = new HashMap<>();
        HashMap<String, Integer> last = new HashMap<>();
        HashSet<String> full = new HashSet<>();
        FileItem fi = items.get(0);
        InputStream sr = fi.getInputStream();
        InputStreamReader nr = new InputStreamReader(sr);
        BufferedReader br = new BufferedReader(nr);
        String tmp = br.readLine();
        
        if(tmp!=null)
            tmp=br.readLine();
        while(tmp != null){
            String arr[] = tmp.split("-");
            if(arr.length==1){
                tmp = br.readLine();
                continue;
            }
            String[] names = arr[0].split(",");
            if(names.length!=2){
                tmp = br.readLine();
                continue;
            }
            addToHast.add(first, names[1].trim());
            addToHast.add(last, names[0].trim());
            addToHast.addSet(full, arr[0].trim());
               tmp = br.readLine();
        }
        br.close();
        first = addToHast.sortHashMapByValues(first);
        last = addToHast.sortHashMapByValues(last);
        %>
        <div class="alert alert-info">
            <p>Unique First Names: <%=first.size()%></p>
            <p>Unique Last Names: <%=last.size()%></p>
            <p>Unique Full Names: <%=full.size()%></p>
            
        </div>
            <div class="row">
          <div id="myGrid" style="height: 600px;width:400px;" class="ag-theme-balham"></div>
          <div id="myGrid2" style="height: 600px;width:400px;" class="ag-theme-balham"></div>
          <div id="myGrid3" style="height: 600px;width:700px;" class="ag-theme-balham"></div>
          </div>
    <script type="text/javascript" charset="utf-8">

      // specify the columns
      var columnDefs = [
        {headerName: "First Name", field: "name", editable: false},
        {headerName: "Count", field: "count", editable: false}
        
      ];
      var rowData = [
    <%  
    String[] fn = first.keySet().toArray(new String[first.size()]);
    Boolean isFirst = true;
    for(int i= 0;i < 10; i++)
    {
        
    
            if(!isFirst){
                out.print(",");
            }
            else
            {
             isFirst = false;           
            }
            %>
                    {name: "<%=fn[i]%>",count: "<%=first.get(fn[i])%>" }
            <%
         

            }
    %>    
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
  
  
  <script type="text/javascript" charset="utf-8">
           // specify the columns
      columnDefs = [
        {headerName: "Last Name", field: "name", editable: false},
        {headerName: "Count", field: "count", editable: false},
        
      ];
      var rowData = [
    <%  
    fn = last.keySet().toArray(new String[first.size()]);
    isFirst = true;
    for(int i= 0;i < 10; i++)
    {
        
    
            if(!isFirst){
                out.print(",");
            }
            else
            {
             isFirst = false;           
            }
            %>
                    {name: "<%=fn[i]%>",count: "<%=last.get(fn[i])%>" }
            <%
         

            }
    %>    
    // let the grid know which columns and what data to use
    ];
    gridOptions = {
      columnDefs: columnDefs,
      rowData: rowData,     
      enableSorting: true,
      enableFilter: true,
      animateRows: true
    };

  
  eGridDiv = document.querySelector('#myGrid2');
  new agGrid.Grid(eGridDiv, gridOptions);
  
  </script>
    <script type="text/javascript" charset="utf-8">
           // specify the columns
      columnDefs = [
        {headerName: "Modified Name", field: "full", editable: false},
        {headerName: "First", field: "fname", editable: false},
        {headerName: "Last", field: "lname", editable: false},
        
      ];
      var rowData = [
    <%  
    fn = last.keySet().toArray(new String[first.size()]);
    isFirst = true;
    HashSet<String> modnames = new HashSet<>();
    String[] firstarr = first.keySet().toArray(new String[first.size()]);
    String[] lastarr = last.keySet().toArray(new String[last.size()]);
    Random r = new Random();
    IntStream rfirst = r.ints(0,first.size()-1);
    IntStream rlast = r.ints(0,last.size()-1);
    for(int i= 0;i < Integer.valueOf(modifiesCount); i++)
    {
            String fullname = "";
            String lastname = "";
            String firstname = "";
            
            while(true)
            {
               
                firstname = firstarr[r.nextInt(first.size())];
                lastname = lastarr[r.nextInt(last.size())];
                fullname = lastname + ", " + firstname;
                if(full.contains(fullname))
                    continue;
                first.remove(firstname);
                last.remove(lastname);
                break;
            }
            if(first.size() == 0 || last.size() == 0)
                break;
            if(!isFirst){
                out.print(",");
            }
            else
            {
             isFirst = false;           
            }
            %>
                    {full: "<%=fullname%>",fname: "<%=firstname%>",lname: "<%=lastname%>" }
            <%
         

            }
    %>    
    // let the grid know which columns and what data to use
    ];
    gridOptions = {
      columnDefs: columnDefs,
      rowData: rowData,     
      enableSorting: true,
      enableFilter: true,
      animateRows: true
    };

  
  eGridDiv = document.querySelector('#myGrid3');
  new agGrid.Grid(eGridDiv, gridOptions);
  
  </script>
  <%
  }
    }
    
  
%>
</center>
</body>