package kr.co.domain;

public class LikeDTO {
	private int likeNum;
	private int num;
	private String id;

	public LikeDTO() {
	
	}

	public LikeDTO(int likeNum, int num, String id) {
		super();
		this.likeNum = likeNum;
		this.num = num;
		this.id = id;
	}

	public int getLikeNum() {
		return likeNum;
	}

	public void setLikeNum(int likeNum) {
		this.likeNum = likeNum;
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
}
