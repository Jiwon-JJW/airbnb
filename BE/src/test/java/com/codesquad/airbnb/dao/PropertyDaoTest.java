package com.codesquad.airbnb.dao;

import com.codesquad.airbnb.domain.Property;
import com.codesquad.airbnb.dto.PropertiesResponseDto;
import com.codesquad.airbnb.dto.PropertyDto;
import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.time.LocalDate;
import java.util.List;


import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
public class PropertyDaoTest {
    private Logger logger = LoggerFactory.getLogger(PropertyDaoTest.class);

    @Autowired
    PropertyDao propertyDao;

    @Test
    void propertyDao_findById() {
        Property property = propertyDao.findById(1L);
        assertThat(property).isNotNull();
        logger.info("Find property by propertyDao: {}",
                property);
    }

    @Test
    void propertyDao_findByAll() {
        List<Property> properties = propertyDao.findAll();
        for(Property property : properties){
            assertThat(property).isNotNull();
            logger.info("Find property by propertyDao: {}",
                    property);
        }
    }

    @Test
    void propertyDao_findBy() {
        PropertiesResponseDto properties = propertyDao.findBy(1L, LocalDate.of(2021,5,20),LocalDate.of(2021,5,23),
                10000, 100000, 2,0,0);
        for(PropertyDto property : properties.getProperties()){
            assertThat(property).isNotNull();
            logger.info("Find property by propertyDao: {}",
                    property);
        }
    }
}
