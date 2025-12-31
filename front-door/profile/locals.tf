locals {
  default_route = {
    patterns_to_match = ["/*"]
    supported_protocols = ["Http","Https"]
    link_to_default_domain = false
    https_redirect_enabled = true
    cache  = {
        compression_enabled = true
        content_types_to_compress = [
            "application/eot",
            "application/font",
            "application/font-sfnt",
            "application/javascript",
            "application/json",
            "application/opentype",
            "application/otf",
            "application/pkcs7-mime",
            "application/truetype",
            "application/ttf",
            "application/vnd.ms-fontobject",
            "application/xhtml+xml",
            "application/xml",
            "application/xml+rss",
            "application/x-font-opentype",
            "application/x-font-truetype",
            "application/x-font-ttf",
            "application/x-httpd-cgi",
            "application/x-javascript",
            "application/x-mpegurl",
            "application/x-opentype",
            "application/x-otf",
            "application/x-perl",
            "application/x-ttf",
            "font/eot",
            "font/ttf",
            "font/otf",
            "font/opentype",
            "image/svg+xml",
            "text/css",
            "text/csv",
            "text/html",
            "text/javascript",
            "text/js",
            "text/plain",
            "text/richtext",
            "text/tab-separated-values",
            "text/xml",
            "text/x-script",
            "text/x-component",
            "text/x-java-source",
        ]
        query_string_caching_behavior = "UseQueryString"
        query_strings = []
    }
    }
    default_load_balancing = {
        sample_size = 4
        successful_samples_required = 3
        additional_latency_in_milliseconds = 50
    }
    default_health_probe = {
        interval_in_seconds = 100
        path                = "/"
        protocol            = "Https"
        request_type        = "HEAD"
    }
    tls = {
        certificate_type    = "ManagedCertificate"
        minimum_tls_version = "TLS12"
    }
}