package com.persistent.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.persistent.model.Producto;

public class ProductoDao extends DAO {

	public void insertProduct(Producto p) throws Exception {
		Timestamp fecha = new Timestamp(System.currentTimeMillis());
		try {
			this.ConnectionPostgresql();
			PreparedStatement st = this.getCnn().prepareStatement(
					"INSERT INTO producto(descripcion,precio,codigo_barras,fabricante,estado,existencia,id_usu_ing,"
							+ "nom_usu_ing,fec_ing,id_usu_mod,nom_usu_mod,fec_mod)  VALUES (?,?,?,?,?,?,?,?,?,?,?,?)");

			// st.setInt(1, user.getId_user());
			st.setString(1, p.getDescripcion());
			st.setFloat(2, p.getPrecio());
			st.setString(3, p.getCodigo_barras());
			st.setString(4, p.getFabricante());
			st.setString(5, p.getEstado());
			st.setInt(6, p.getExistencia());
			st.setString(7, p.getId_usu_ing());
			st.setString(8, p.getNom_usu_ing());
			st.setTimestamp(9, fecha);

			st.setString(10, p.getId_usu_mod());
			st.setString(11, p.getNom_usu_mod());
			st.setTimestamp(12, fecha);
			st.executeUpdate();

			this.closeDB();

		} catch (Exception e) {
			System.out.println("Ocurrio un error insert product : " + e.getMessage());
			throw e;
		}
	}

	public List<Producto> allProducts() throws Exception {
		List<Producto> list = new ArrayList<Producto>();

		ResultSet rs;

		try {
			this.ConnectionPostgresql();
			PreparedStatement st = this.getCnn().prepareStatement("SELECT *FROM producto");

			rs = st.executeQuery();
			while (rs.next()) {
				Producto pd = new Producto();
				pd.setId_producto(rs.getInt("id_producto"));
				pd.setDescripcion(rs.getString("descripcion"));
				pd.setPrecio(rs.getFloat("precio"));
				pd.setExistencia(rs.getInt("existencia"));
				pd.setFabricante(rs.getString("fabricante"));
				pd.setFec_ing(rs.getString("fec_ing"));
				pd.setEstado(rs.getString("estado"));
				pd.setCodigo_barras(rs.getString("codigo_barras"));
				list.add(pd);
			}
			this.closeDB();

		} catch (Exception e) {
			System.out.println("Ocurrio un error GET LIST PRODUCT : " + e.getMessage());
			throw e;
		}
		return list;
	}

	public Producto getProduct(int id) throws Exception {
		ResultSet rs;
		Producto pd = new Producto();
		try {
			this.ConnectionPostgresql();
			PreparedStatement st = this.getCnn().prepareStatement("SELECT *FROM producto WHERE id_producto=?");
			st.setInt(1, id);
			rs = st.executeQuery();
			if (rs.next()) {
				pd.setId_producto(rs.getInt("id_producto"));
				pd.setDescripcion(rs.getString("descripcion"));
				pd.setPrecio(rs.getFloat("precio"));
				pd.setExistencia(rs.getInt("existencia"));
				pd.setFabricante(rs.getString("fabricante"));
				pd.setFec_ing(rs.getString("fec_ing"));
				pd.setEstado(rs.getString("estado"));
				pd.setCodigo_barras(rs.getString("codigo_barras"));
			}
			this.closeDB();

		} catch (Exception e) {
			System.out.println("Ocurrio un error getProduct : " + e.getMessage());
			throw e;
		}
		return pd;
	}

	public void updateProduct(Producto p, int id) throws Exception {
		Timestamp fecha = new Timestamp(System.currentTimeMillis());
		try {
			this.ConnectionPostgresql();
			PreparedStatement st = this.getCnn().prepareStatement(
					"UPDATE producto SET descripcion=?,precio=?,existencia=?,fabricante=?,estado=?,codigo_barras=?,"
							+ "id_usu_mod=?,nom_usu_mod=?,fec_mod=? WHERE id_producto=?");

			st.setString(1, p.getDescripcion());
			st.setFloat(2, p.getPrecio());
			st.setInt(3, p.getExistencia());
			st.setString(4, p.getFabricante());
			st.setString(5, p.getEstado());
			st.setString(6, p.getCodigo_barras());

			st.setString(7, p.getId_usu_mod());
			st.setString(8, p.getNom_usu_mod());
			st.setTimestamp(9, fecha);

			st.setInt(10, id);
			st.executeUpdate();

			this.closeDB();

		} catch (Exception e) {
			System.out.println("Ocurrio un error updateProduct : " + e.getMessage());
			throw e;
		}

	}

	public void deleteProduct(int id) throws Exception {
		try {
			this.ConnectionPostgresql();
			PreparedStatement st = this.getCnn().prepareStatement("DELETE FROM producto WHERE id_producto=?");
			st.setInt(1, id);
			st.executeUpdate();
			this.closeDB();

		} catch (Exception e) {
			System.out.println("Ocurrio un error deleteProduct : " + e.getMessage());
			throw e;
		}

	}
}