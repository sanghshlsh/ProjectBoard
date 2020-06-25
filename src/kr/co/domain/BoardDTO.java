package kr.co.domain;

import java.io.Serializable;
import java.sql.Date;

import java.util.List;


public class BoardDTO implements Serializable {

	
	private static final long serialVersionUID = 1L;
	private int num;
	private String id;
	private String title;
	private String content;
	private int readcnt;
	private Date writeday;
	private int money;
	private String category;
	private String location;
	private int likes;

	private String title_location;
	private int visible;
	private List<AttDTO> attList;
	private String nickname;
	private int replycnt;
	
	

	public BoardDTO(int num, String id, String title, String content, int readcnt, Date writeday, int money,
			String category, String location, int likes)  {
		super();
		this.num = num;
		this.id = id;
		this.title = title;
		this.content = content;
		this.readcnt = readcnt;
		this.writeday = writeday;
		this.money = money;
		this.category = category;
		this.location = location;
		this.likes = likes;

		
	}


	
	public BoardDTO(int num, String id, String title, String content, int readcnt, Date writeday, int money,
			String category, String location, int likes,  List<AttDTO> attList ,String nickname ,int replycnt) {

		super();
		this.num = num;
		this.id = id;
		this.title = title;
		this.content = content;
		this.readcnt = readcnt;
		this.writeday = writeday;
		this.money = money;
		this.category = category;
		this.location = location;
		this.likes = likes;
		this.nickname = nickname;
		this.attList = attList;
		this.replycnt = replycnt;
	}

	
	

	public BoardDTO() {
		// TODO Auto-generated constructor stub
	}


	
	public List<AttDTO> getAttList() {
		return attList;
	}

	public void setAttList(List<AttDTO> attList) {
		this.attList = attList;
	}


	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getReadcnt() {
		return readcnt;
	}

	public void setReadcnt(int readcnt) {
		this.readcnt = readcnt;
	}

	public Date getWriteday() {
		return writeday;
	}

	public void setWriteday(Date writeday) {
		this.writeday = writeday;
	}

	public int getMoney() {
		return money;
	}

	public void setMoney(int money) {
		this.money = money;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public int getLikes() {
		return likes;
	}

	public void setLikes(int likes) {
		this.likes = likes;
	}


	public String getTitle_location() {
		return title_location;
	}

	public void setTitle_location(String title_location) {
		this.title_location = title_location;
	}


	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public int getVisible() {
		return visible;
	}

	public void setVisible(int visible) {
		this.visible = visible;
	}


	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + num;
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
		BoardDTO other = (BoardDTO) obj;
		if (num != other.num)
			return false;
		return true;
	}


	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}



	public int getReplycnt() {
		return replycnt;
	}



	public void setReplycnt(int replycnt) {
		this.replycnt = replycnt;
	}

	
}

