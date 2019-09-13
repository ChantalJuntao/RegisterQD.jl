@testset "default_minwidth_rot" begin
    img = rand(3, 10)
    ci = CartesianIndices(img)
    θ = RegisterQD.default_minrot(ci)
    @test θ ≈ 0.01 rtol=0.1
    θ = RegisterQD.default_minrot(ci, [1 0; 0 2])
    @test θ ≈ 0.005 rtol=0.1
    θ = RegisterQD.default_minrot(ci, [3 0; 0 1])
    @test θ ≈ 0.007 rtol=0.1
    θ = RegisterQD.default_minrot(ci, [10 0; 0 1])
    @test θ ≈ 0.01/3 rtol=0.1
    img = rand(3, 10, 5)
    ci = CartesianIndices(img)
    θ = RegisterQD.default_minrot(ci)
    @test θ ≈ 0.1/sqrt(3^2 + 10^2 + 5^2) rtol=1e-3
end

#TODO add a testset for other support functions
#rotations
@testset "support functions?" begin
    #rot
    randarray = rand(4)
    randarray = randarray./sqrt(sum(randarray.^2))
    @test rot(randarray[2:4]...).linear ≈ Quat(randarray...)
    @test isrotation(rot(randarray[2:4]...).linear)

    #test that pscale = translation * diag(SD)
    mytranslation = Translation(rand(2))
    SD2 = diagm(rand(2))
    scaledtranslation = RegisterQD.pscale(mytranslation, SD2)
    @test scaledtranslation.translation ≈ mytranslation.translation.*diag(SD2)

    mytranslation3 = Translation(rand(3))
    SD3 = diagm(rand(3))
    scaledtranslation3 = RegisterQD.pscale(mytranslation3, SD3)
    @test scaledtranslation3.translation ≈ mytranslation3.translation.*diag(SD3)
end #support functions

@testset "exported support functions?" begin
    #arrayscale
    mytfm = AffineMap(SMatrix{3,3}(rand(3,3)), SVector{3}(rand(3)))
    SD = diagm(rand(3))
    @test  arrayscale(mytfm, SD) ≈ AffineMap(SD\mytfm.linear*SD, mytfm.translation./diag(SD))
    #TODO more ways to test this please

    #test restrict
    myimage = rand(64,64) #why is half of 64 33?!
    scaled1 = RegisterQD.rescale(myimage, [1,1])
    scaled2 = RegisterQD.rescale(myimage, [2,2])
    scaled3 = RegisterQD.rescale(myimage, [3,3])
end #exported functions
