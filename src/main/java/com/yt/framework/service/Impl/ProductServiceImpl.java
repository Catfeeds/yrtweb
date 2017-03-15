package com.yt.framework.service.Impl;

import org.springframework.stereotype.Service;

import com.yt.framework.persistent.entity.Product;
import com.yt.framework.service.ProductService;

/**
 * 
 * @author mocoy
 *
 */
@Service(value = "productService")
public class ProductServiceImpl extends BaseServiceImpl<Product>implements ProductService {
}
