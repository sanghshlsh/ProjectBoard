package kr.co.domain;

import java.sql.Date;

public class LogDTO {
	private int logNum;
	private String whoSeeId;
	private String ShownId;
	private Date whichDay;
	
	public LogDTO() {
		// TODO Auto-generated constructor stub
	}

	public LogDTO(int logNum, String whoSeeId, String shownId, Date whichDay) {
		super();
		this.logNum = logNum;
		this.whoSeeId = whoSeeId;
		ShownId = shownId;
		this.whichDay = whichDay;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + logNum;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		LogDTO other = (LogDTO) obj;
		if (logNum != other.logNum)
			return false;
		return true;
	}

	public int getLogNum() {
		return logNum;
	}

	public void setLogNum(int logNum) {
		this.logNum = logNum;
	}

	public String getWhoSeeId() {
		return whoSeeId;
	}

	public void setWhoSeeId(String whoSeeId) {
		this.whoSeeId = whoSeeId;
	}

	public String getShownId() {
		return ShownId;
	}

	public void setShownId(String shownId) {
		ShownId = shownId;
	}

	public Date getWhichDay() {
		return whichDay;
	}

	public void setWhichDay(Date whichDay) {
		this.whichDay = whichDay;
	}
	
}