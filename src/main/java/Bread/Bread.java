package Bread;

import java.io.Serializable;
import java.util.ArrayList;

public class Bread implements Serializable {
	
	private String name;
	private int price;
	private String info;
	private String eatbydate;
	private int delivery;
	private String allergy;
	private String img;
	
	public Bread() {}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public String getEatbydate() {
		return eatbydate;
	}
	public void setEatbydate(String eatbydate) {
		this.eatbydate = eatbydate;
	}
	public int getDelivery() {
		return delivery;
	}
	public void setDelivery(int delivery) {
		this.delivery = delivery;
	}
	public String getAllergy() {
		return allergy;
	}
	public void setAllergy(String allergy) {
		this.allergy = allergy;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img=img;
	}

}
