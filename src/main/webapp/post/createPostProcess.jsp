<%@ page import="study.postvote.service.PostService" %>
<%@ page import="study.postvote.service.VoteService" %>
<%@ page import="study.postvote.service.OptionService" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="study.postvote.domain.Post" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="study.postvote.domain.Vote" %>
<%@ page import="study.postvote.domain.Option" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDate" %>

<%--
  Created by IntelliJ IDEA.
  User: FastPc
  Date: 2023-06-02
  Time: 오전 10:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%

    /*
    * TODO: 현재 유저가 데베에 있는 유저인지 확인.
    * */
    PostService postService = new PostService();
    VoteService voteService = new VoteService();
    OptionService optionService = new OptionService();
    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
    DateTimeFormatter dateTimeFormatter =  DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
    Date start_time_date = new Date();
    List<Option> optionList = new ArrayList<>();


    request.setCharacterEncoding("UTF8");
    String title = request.getParameter("title");
    String start_time = LocalDateTime.now().format(dateTimeFormatter);
//    String end_day = request.getParameter("end_day");
//            +" 23:59:59";
    String end_time = request.getParameter("end_time").replace("T", " ")+":00";

    System.out.println(start_time + " " +end_time);
    String description = request.getParameter("description");
    String[] labels = request.getParameterValues("labels");
    int isAnonymous = Integer.parseInt(request.getParameter("isAnonymous"));
    String inputType = request.getParameter("inputType");
    Long userId = (Long)session.getAttribute("userId");

    out.println(userId + "<br/>");
    out.println(title+"<br/>");
    out.println(start_time+"<br/>");
    out.println(end_time+"<br/>");
    out.println(description+"<br/>");
    out.println(labels+"<br/>");
    out.println(isAnonymous+"<br/>");
    out.println(inputType+"<br/>");


    userId = (long)session.getAttribute("userId");

    Post post = new Post(userId, title, description, LocalDateTime.parse(start_time, dateTimeFormatter));
    Long post_id = postService.save(post);
    Vote vote = new Vote(post_id, isAnonymous, inputType, LocalDateTime.parse(start_time, dateTimeFormatter), LocalDateTime.parse(end_time, dateTimeFormatter));
    Long vote_id = voteService.insert(vote);
    for(String label: labels) optionList.add(new Option(label, vote_id));
    optionService.saveList(optionList);
    response.sendRedirect("./list.jsp");

%>