package com.hobbyist.member.model.service;

import static common.JdbcTemplate.close;
import static common.JdbcTemplate.getConnection;
import static common.JdbcTemplate.commit;
import static common.JdbcTemplate.rollback;

import java.sql.Connection;

import com.hobbyist.member.model.dao.MemberDao;
import com.hobbyist.member.model.vo.Member;

public class MemberService {

	private MemberDao dao = new MemberDao();
	
	public Member selectOne(Member m) {
		Connection conn = getConnection();
		Member result = dao.selectOne(conn,m);
		close(conn);
		return result;
	}
	
	public int enrollMember(Member m) {
		Connection conn = getConnection();
		int result = dao.enrollMember(conn,m);
		if(result>0) {
			commit(conn);
		}
		else {
			rollback(conn);
		}
		close(conn);
		return result;
	}

	public int emailCheck(String finalEmail) {
		Connection conn = getConnection();
		int result = dao.emailCheck(conn, finalEmail);
		close(conn);
		return result;
	}

	public int nicknameCheck(String memberNickname) {
		Connection conn = getConnection();
		int result = dao.nicknameCheck(conn, memberNickname);
		close(conn);
		return result;
	}
}