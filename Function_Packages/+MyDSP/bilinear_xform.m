function [numz, denz] = bilinear_xform(nums, dens, fs)
    % [numz, denz] = bilinear_xform(nums, dens, fs)
    % Info:
    % By: Dr. Gabrielson
    % Last Edit: ???
    % This routine performs a bilinear transformation from the s-domain
    % expression given by the numerator, nums, and denominator, dens, polynomial
    % coefficient vectors (in order from highest power of s to the constant)
    % to the z-domain expression given by the numerator, bb, and denominator,
    % aa, polynomial coefficient vectors (in order from constant to highest
    % power of z^-1) for the specified sampling rate, fs. The coefficient
    % orders are chosen to conform to the MatLab conventions.
    %
    % Typical usage:
    %
    % [bb, aa] = bilinear_xform(nums, dens, fs);
    %
    % This bilinear transformation produces results equivalent to the MatLab
    % Signal-Processing-Toolbox routine 'bilinear' when that routine is used
    % in the transfer function mode. However, bilinear_xform does not first
    % convert
    % to state-space as does 'bilinear'; this routine uses the more conventional
    % (though perhaps less efficient) direct transformation.
    %
    % In typical use, this routine would be used to find the coefficients for
    % a time-domain filter:
    %
    % [bb, aa] = bilinear_xform(nums, dens, fs);
    % yfiltered = filter(bb, aa, yunfiltered);
    %
    [dc, nn] = size(nums);
    % Check dimensions and force into row vectors
    if dc ~= 1
     nums = nums.'; nn = dc;
    end
    [dc, mm] = size(dens);
    if dc ~= 1
     dens = dens.'; mm = dc;
    end
    %
    % Check for proper relative order of numerator compared to denominator
    if nn > mm
     error(' Order of numerator cannot exceed order of denominator')
    end
    %
    % Zero fill numerator, if necessary, to make it the same length as the
    % denominator vector. This is done simply to save some logic in the code
    % below.
    if nn < mm
     padz = zeros(1,(mm-nn)); nums = [padz,nums];
    end
    %
    % The bilinear transformation is produced by taking the response
    % expression in the s-domain and replacing s with the quantity,
    % (2*fs)*(1 - z^-1)/(1 + z^-1). Here, fs is the sampling rate
    % (inexplicably written as 1/T in most texts) and z^-1 is
    %
    % z^-1 = exp(-j*pi*f/fs)
    %
    % When this substitution is made, the numerator and denominator are no
    % longer proper polynomials (in z^-1). Multiply numerator and denominator
    % by (1 + z^-1)^m (where m is the highest power of s in the original
    % denominator) to put them into a form that can be simplified to
    % coefficients of ascending powers of z^-1. (In this code, m would be
    % mm - 1.)
    %
    % The key to understanding the code below is that, after the substitution
    % of (2*fs)*(1 - z^-1)/(1 + z^-1) for s and the subsequent multiplication
    % by (1 + z^-1)^m, every term has the form of ((1 + z^-1)^ma)*((1 - z^-
    % 1)^mb)
    % where ma+mb = m. So the roots of the resulting polynomial (for that
    % particular term) are ma negative ones and mb positive ones.
    %
    % Set up polynomial root vector, initially to all negative ones; note
    % that the order is mm-1: mm is the number of terms in the original vector
    % of the denominator polynomial in the s-domain; if that polynomial were
    % second order (a quadratic), then mm would be 3 and m, the order notation
    % used above, would be 2.
    rootv = - ones(1,mm-1);
    % Set up accumulators for numerator and denominator coefficients
    numz = zeros(1,mm) ; denz = numz;
    % Initialize leading factor
    fsfact = 1;
    %
    % Develop polynomial coefficients term by term. Note that in MatLab, the
    % assumed order for values in polynomial coefficient vectors in the
    % s-domain is in decreasing powers of s while the assumed order for values
    % in polynomial coefficient vectors in the z-domain is in increasing
    % powers of z^-1. This accounts for the reversed indexing between nums
    % and numz or between dens and denz. The MatLab order is preserved so
    % that this routine is compatible with other MatLab routines.
    for ii=1:mm
     basepoly = poly(rootv)*fsfact;
     numz = numz + basepoly*nums(mm-ii+1); % (nums values stored in opposite
    %order)
     denz = denz + basepoly*dens(mm-ii+1); % (dens values stored in opposite
    %order)
    % Modify fsfact and rootv except on final pass through loop
    if ii<mm
     fsfact = fsfact*2*fs;
     rootv(ii) = rootv(ii) + 2; % Add 2 to change -1 to +1
    end
    end
    %
    % Normalize coefficients (not necessary but done for compatibility with
    % other MatLab routines)
    numz = numz/denz(1); denz = denz/denz(1);
end