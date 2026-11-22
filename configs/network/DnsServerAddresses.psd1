@{
    Cloudflare = @{
        Name          = 'Cloudflare DNS'
        IPV4Addresses = @('1.1.1.1', '1.0.0.1')
        IPV6Addresses = @('2606:4700:4700::1111', '2606:4700:4700::1001')
        OptionId      = '1'
        Order         = 1
    }

    Google = @{
        Name          = 'Google DNS'
        IPV4Addresses = @('8.8.8.8', '8.8.4.4')
        IPV6Addresses = @('2001:4860:4860::8888', '2001:4860:4860::8844')
        OptionId      = '2'
        Order         = 2
    }

    Quad9 = @{
        Name          = 'Quad9 DNS'
        IPV4Addresses = @('9.9.9.9', '149.112.112.112')
        IPV6Addresses = @('2620:fe::fe', '2620:fe::9')
        OptionId      = '3'
        Order         = 3
    }

    NextDNS = @{
        Name          = 'NextDNS'
        IPV4Addresses = @('45.90.28.210', '45.90.30.210')
        IPV6Addresses = @('2a07:a8c0::2c:2ff8', '2a07:a8c1::2c:2ff8')
        OptionId      = '4'
        Order         = 4
    }

    KeepCurrent = @{
        Name          = 'Keep Current DNS'
        OptionId      = 'K'
        Order         = 5
    }

    Reset = @{
        Name          = 'Reset DNS to default'
        OptionId      = 'R'
        Order         = 6
    }
}
