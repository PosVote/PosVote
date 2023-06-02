<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page
        import="study.postvote.domain.User, study.postvote.service.UserService" %>
<%@ page import="study.postvote.domain.type.Status" %>

<%
    Long userId = Long.valueOf(request.getParameter("userId"));
    String type = request.getParameter("type");
    UserService userService = new UserService();

    User user = userService.findById(userId);

    if (type.equals("accept")) {
        userService.updateStatus(user, Status.ACCEPT);
    } else {
        userService.deleteById(user.getUserId());
    }
    String redirectUrl = request.getHeader("referer");

    response.sendRedirect(redirectUrl);
%>