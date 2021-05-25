package com.codesquad.airbnb.service;

import com.codesquad.airbnb.dao.PropertyDAO;
import com.codesquad.airbnb.dto.PriceSearchDTO;
import com.codesquad.airbnb.dto.PropertiesResponseDTO;
import com.codesquad.airbnb.dto.PropertyDetailResponseDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
public class PropertyService {

    private PropertyDAO propertyDao;

    @Autowired
    public PropertyService(PropertyDAO propertyDao) {
        this.propertyDao = propertyDao;
    }

    int getAveragePrice(Long locationId) {
        int average = 0;
        List<Integer> prices = propertyDao.findPricesByLocationId(locationId);

        for (Integer i : prices) {
            average += i;
        }

        return average / prices.size();
    }

    int[] getPropertyCountsByPriceRange(Long locationId) {
        int[] priceCounts = new int[20];
        List<Integer> prices = propertyDao.findPricesByLocationId(locationId);

        for (Integer i : prices) {
            priceCounts[i / 50000]++;
        }

        return priceCounts;
    }

    public PriceSearchDTO priceSearch(Long locationId) {
        PriceSearchDTO priceSearchDTO = new PriceSearchDTO();
        priceSearchDTO.setAveragePrice(getAveragePrice(locationId));
        priceSearchDTO.setNumberOfRooms(getPropertyCountsByPriceRange(locationId));

        return priceSearchDTO;
    }

    public PropertiesResponseDTO findBy(Long locationId, LocalDate checkIn, LocalDate checkOut, int minPrice, int maxPrice, int adult, int children, int infant) {
        return propertyDao.findBy(locationId, checkIn, checkOut, minPrice, maxPrice, adult, children, infant);
    }

    public PropertyDetailResponseDTO findPropertyDetailByPropertyId (Long propertyId) {
        return propertyDao.findPropertyDetailByPropertyId(propertyId);
    }
}
