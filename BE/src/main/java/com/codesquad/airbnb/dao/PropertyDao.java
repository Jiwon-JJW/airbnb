package com.codesquad.airbnb.dao;

import com.codesquad.airbnb.domain.Property;
import com.codesquad.airbnb.domain.PropertyDetail;
import com.codesquad.airbnb.domain.WishList;
import com.codesquad.airbnb.dto.PropertiesResponseDto;
import com.codesquad.airbnb.dto.PropertyDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.SqlParameterValue;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.time.LocalDate;
import java.util.List;

@Repository
public class PropertyDao {

    private final JdbcTemplate jdbcTemplate;

    @Autowired
    public PropertyDao(DataSource dataSource) {
        jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public class PropertyRowMapper implements RowMapper<Property> {
        // interface method
        public Property mapRow(ResultSet rs, int rowNum) throws SQLException {
            Property property = new Property(rs.getLong("id"), rs.getString("name"), rs.getInt("price"));
            return property;
        }
    }

    public class PropertyDetailRowMapper implements RowMapper<PropertyDto> {

        // interface method
        @Override
        public PropertyDto mapRow(ResultSet rs, int rowNum) throws SQLException {
            return PropertyDto.of(rs.getLong("id"), rs.getString("name"),
                    rs.getBoolean("bookmark"), rs.getInt("price"),
                    0, rs.getInt("review_count"), rs.getInt("rating"));
        }
    }

    public Property findById(Long id) {
        String sql = "SELECT p.id, p.name, p.price FROM property as p WHERE id = ?";

        return jdbcTemplate.queryForObject(sql, new PropertyRowMapper(), id);
    }

    public List<Property> findAll() {
        String sql = "SELECT * FROM property";
        List<Property> properties = jdbcTemplate.query(sql, new PropertyRowMapper());

        return properties;
    }

    public PropertiesResponseDto findBy(Long locationId, LocalDate checkIn, LocalDate checkOut,
                                        int minPrice, int maxPrice, int adult, int children, int infant) {
        int maxOccupancy = adult+children+infant;
        String sql = "select p.id, p.name, wl.bookmark, p.price, pd.review_count, pd.rating " +
                "from property as p, " +
                "property_detail as pd, " +
                "wish_list as wl " +
                "where p.id = pd.property_id " +
                "and p.id = wl.property_id " +
                "and p.location_id = ? " +
                "and pd.max_occupancy >= ? " +
                "and p.price >= ? " +
                "and p.price <= ?";
        // TODO: userid도 함께 확인해서 wishList를 찾는것이 좋을 것 같음...

        List<PropertyDto> propertyDto = jdbcTemplate.query(sql, new PropertyDetailRowMapper(),
                new SqlParameterValue(Types.BIGINT, locationId),
                new SqlParameterValue(Types.INTEGER, maxOccupancy),
                new SqlParameterValue(Types.INTEGER, minPrice),
                new SqlParameterValue(Types.INTEGER, maxPrice));

        propertyDto.stream()
                .forEach(propertyDto1 -> propertyDto1.setImages(findImageByPropertyId(propertyDto1.getPropertyId())));

        PropertiesResponseDto propertyDtos = new PropertiesResponseDto(propertyDto);

        return propertyDtos;
    }

    private List<String> findImageByPropertyId(Long propertyId) {
        String sql = "SELECT * FROM image " +
                "WHERE image.property_id = ?";

        List<String> images = jdbcTemplate.query(sql, new RowMapper<String>() {
            @Override
            public String mapRow(ResultSet rs, int rowNum) throws SQLException {
                return rs.getString("image_url");
            }
        }, propertyId);
        return images;
    }
}

