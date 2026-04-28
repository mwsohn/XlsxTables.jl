"""
    hltest(glmout, q = 10)

Produces Hosmer-Leneshow Test statistics for a logistic regression. It outputs a
tuple consisting of Hosmer-Lemeshow statistic, degree of freedom, and its p-value.
The option `q` can be used to specify the number of groups to use.
"""
function hltest(glmout, q=10)
    d = DataFrame(yhat=predict(glmout), y=glmout.model.rr.y)
    d.group = xtile(d.yhat, nq=q)

    df = combine(groupby(d, :group), nrow => :n, :y => sum => :o1, :yhat => sum => :e1)
    df.o0 = df.n .- df.o1
    df.e0 = df.n .- df.e1

    hlstat = sum((df.o1 .- df.e1) .^ 2 ./ df.e1 .+ (df.o0 .- df.e0) .^ 2 ./ df.e0)

    dof = q - 2

    pval = Distributions.ccdf(Distributions.Chisq(dof), hlstat)

    return (hlstat, dof, pval)
end