function crc = crc16(poly, seed, data)
    % CRC-16 implementation (bitwise)
    % Inputs:
    %   poly - polynomial (e.g., hex2dec('8005') or hex2dec('1021'))
    %   seed - initial CRC value (e.g., 0 or hex2dec('FFFF'))
    %   data - uint8 array of input bytes
    %
    % Returns:
    %   crc - uint16 result

    crc = uint16(seed);
    poly = uint16(poly);
    
    for i = 1:length(data)
        crc = bitxor(crc, bitshift(uint16(data(i)), 8));  % Bring byte into top 8 bits

        for j = 1:8
            if bitand(crc, uint16(32768))  % 0x8000 = MSB
                crc = bitxor(bitshift(crc, 1), poly);
            else
                crc = bitshift(crc, 1);
            end
        end
    end
    
    crc = bitand(crc, uint16(65535));  % Make sure it's 16-bit
end