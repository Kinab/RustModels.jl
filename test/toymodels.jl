function classicaltoys()

	ds=18   #6 days, 3 observed states 
	da=2
	dtheta=2    

	pi1=kron(hcat(zeros(6),eye(6,5)),rsm(3,3))
	pi2=kron(hcat(zeros(6),eye(6,5)),rsm(3,3))
	pi1[16,:]=[vec(RustModels.rsm(1,8));zeros(10)]
	pi1[17,:]=pi1[16,:]
	pi1[18,:]=pi1[16,:]
	pi2[16,:]=pi1[16,:]
	pi2[17,:]=pi1[16,:]
	pi2[18,:]=pi1[16,:]
	pis=[pi::Array{Float64,2} for pi=(pi1,pi2)]
	spis=[sparse(pi)::SparseMatrixCSC{Float64,Int} for pi=(pi1,pi2)]

	dk=ds

	beta=.95
	mu=fill(1/ds*da,ds,da)

	aa=rand(dk,da,dtheta)
	bb=zeros(dk,da)
	dirm=rustmodel(aa,bb,mu,beta,pis)
	sirm=rustmodel(aa,bb,mu,beta,spis)
	dfrm=rustmodel(aa,bb,mu,beta,spis,16)
	sfrm=rustmodel(aa,bb,mu,beta,spis,16)

	dirm,sirm,dfrm,sfrm
end