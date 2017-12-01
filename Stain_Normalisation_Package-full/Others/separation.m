%% Stain Separation using Macenko's Image specific Stain Matrix for H&E 

disp(['Stain Separation using an Image specific Stain matrix '...
    'estimated using Macenko''s method']);

MacenkoMatrix = EstUsingMacenko( SourceImage );

Deconvolve( SourceImage, MacenkoMatrix, verbose );

%% Stain Separation using Image specific Stain Matrix for H&E 

disp(['Stain Separation using an Image specific Stain matrix estimated '...
    'using the Stain Colour Descriptor Method']);

SCDMatrix = EstUsingSCD( SourceImage );

Deconvolve( SourceImage, SCDMatrix, verbose );
